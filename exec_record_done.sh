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

auth=$1
ip=$2
path=$3

generate_post_data()
{
  cat <<EOF
{
  "path": "$1"
}
EOF
}

curl --insecure -X POST \
  -H 'content-type: application/json' \
  -H 'Authorization: Basic '"$auth"'' \
  -d "$(generate_post_data $path)" "https://$ip:443/api/v1/namespaces/guest/actions/mobile_journalist/record_done"
