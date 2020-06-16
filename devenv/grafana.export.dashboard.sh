#!/bin/sh -x

# API-KEY Grafana, need change
KEY="eyJrIjoiR3dsbXA0Szd1dEtudVNOdmF5YnM0dDlDeXN1bW9nY3UiLCJuIjoiVmlld2VyIiwiaWQiOjF9"
# Grafana Dashboard UID, need change
UID="gatlingTrend"
DIR="./provisioning/dashboards/json/"

tmpFile=$(mktemp)
curl -H "Authorization: Bearer $KEY" \
        "http://localhost:3000/api/dashboards/uid/$UID"\
     -o "$tmp"
jq .dashboard "$tmpFile" > "$DIR/$UID.json"

TITLE=`jq -r '.title' "$DIR/$UID.json"`
jq --arg a "${TITLE} (GIT)" '.title = $a' "$DIR/$UID.json" > "$tmpFile"
mv "$tmpFile" "$DIR/$UID.json"
jq --arg a "${UID}_GIT" '.uid = $a' "$DIR/$UID.json" > "$tmpFile"
mv "$tmpFile" "$DIR/$UID.json"

git add "$DIR/$UID.json"
git commit -m "Update $UID"