#!/bin/sh -x

# API-KEY Grafana, need change
KEY="eyJrIjoiN0ROVjhLS1l6bkJJNUx3eFQyeERvR1BxUzU0ZDQzMTEiLCJuIjoibmV3IiwiaWQiOjF9"
# Grafana Dashboard UID, need change
UID="gatlingNew"
UID_GIT="gatling"
TITLE_GIT="Gatling Report"
DIR="./provisioning/dashboards/json/"

tmpFile=$(mktemp)
curl -H "Authorization: Bearer $KEY" \
        "http://localhost:3000/api/dashboards/uid/$UID"\
     -o "$tmpFile"
jq .dashboard "$tmpFile" > "$DIR/$UID.json"

#TITLE=`jq -r '.title' "$DIR/$UID.json"`
jq --arg a "${TITLE_GIT}" '.title = $a' "$DIR/$UID.json" > "$tmpFile"
mv "$tmpFile" "$DIR/$UID.json"
jq --arg a "${UID_GIT}" '.uid = $a' "$DIR/$UID.json" > "$tmpFile"
mv "$tmpFile" "$DIR/$UID.json"

git add "$DIR/$UID.json"
git commit -m "Update $UID"