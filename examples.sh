
##demonstrates Homegate API usage via curl and jq (https://stedolan.github.io/jq/)
export AUTH="badbabe2e57adc4c001d00dd16363e35"

#get 10 rental appartements in 8005 zurich newest first  and format it with jq and save it in results1.json
curl -s -X GET --header "Accept: application/json" --header "auth: $AUTH" \
"https://api-2445581357976.apicast.io:443/rs/real-estates?language=en&chooseType=rentflat&objectType=appt&zip=8005&SORT=ts&NUMBERRESULTS=40" | jq . > result1.json

#get advertisement id's
cat result1.json | jq ".items[].advertismentId"  > ad_ids.txt

#get details for all ids
for ID in $(cat ad_ids.txt)
do
  curl -s -X GET --header "Accept: application/json" --header "auth: $AUTH" \
  "https://api-2445581357976.apicast.io:443/rs/real-estates/$ID?language=en" | jq -c . >> details.jsonl
done
