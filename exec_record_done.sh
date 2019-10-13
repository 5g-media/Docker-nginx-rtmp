#!/bin/sh

#
# NOTE: It is assumed that openwhisk instance already has guest/mobile_journalist/record_done
# action.
#

#
# Callback script called from RTMP server when recording file is ready to be
# consumed.
#
# :param myip ($1): The ipaddress of this RTMP server
# :param auth ($2): Openwhisk authentication token in base64 format
# :param url  ($3): Openwhisk gateway URL (e.g. https://10.20.2.15:443)
# :param path ($4): Full path to recording file (e.g. /tmp/news_event134343.flv)
#

myip=$1
auth=$2
url=$3
path=$4

filename=$(basename $path)

# payload to openwhisk gateway
generate_post_data()
{
  cat <<EOF
{
  "ipaddress": "$1",
  "filename": "$2"
}
EOF
}

curl --insecure -X POST \
  -H 'content-type: application/json' \
  -H 'Authorization: Basic '"$auth"'' \
  -d "$(generate_post_data $myip $filename)" "$url/api/v1/namespaces/guest/actions/mobile_journalist/record_done"
