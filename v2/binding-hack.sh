#!/bin/bash

B64_URL= $(ibmcloud resource service-key "https://api.eu-gb.tone-analyzer.watson.cloud.ibm.com/instances/2bb5f643-23b6-4b64-ae9a-52da225cd6aa" --output json | jq .[0].credentials.url -j | base64 -w 0)
B64_APIKEY= $(ibmcloud resource service-key "cip6v_Tgbl6Nm-81JFLD5w8XVY7uBLXByYGeDosfDjzw" --output json | jq .[0].credentials.apikey -j | base64 -w 0)

cat <<EOF | oc apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: binding-tone
  namespace: sn-labs-moolayil13
type: Opaque
data:
  url: $B64_URL
  apikey: $B64_APIKEY
EOF