#!/bin/bash

KEY="REPLACE_ME_WITH_GRAFANA_KEY"
HOST="http://example.com"

if [ ! -d dashboards ]; then
    mkdir -p dashboards
fi

for dash in $(curl -k -H "Authorization: Bearer $KEY" $HOST/api/search\?query\=\& |tr ']' '\n' |cut -d "," -f 5 | grep db |cut -d\" -f 4 |cut -d\/ -f2); do
  curl -k -H "Authorization: Bearer $KEY" $HOST/api/dashboards/db/$dash | sed 's/"id":[0-9]\+,/"id":null,/' | sed 's/\(.*\)}/\1,"overwrite": true}/' > dashboards/$dash.json
done
