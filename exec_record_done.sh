#!/bin/sh

#
# Callback script called from RTMP server sink when recording is ready to be
# consumed.
#
# :param path ($1): Full path to recording file
#
# It is assumed that the following environment variables are already set inside RTMP server
#
# - OPENWHISK_IP ipaddress to openwhisk gateway
# - OW_AUTH_BASE64 authentication token in 64base format
#

path=$1

generate_post_data()
{
  cat <<EOF
{
  "path": "$1",
}
EOF
}

curl --insecure -X POST \
  -H 'content-type: application/json' \
  -H 'Authorization: Basic '"$OW_AUTH_BASE64"'' \
  -d "$(generate_post_data $path)" https://$OPENWHISK_IP:443/api/v1/namespaces/guest/actions/mobile_journalist/record_done