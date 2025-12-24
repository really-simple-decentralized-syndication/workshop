#!/bin/bash

set -x
POSTER_DOMAIN=ttrpg-ledger.com
POST_DOMAIN=ttrpg-ledger.com
POST_PATH=rsds/first-post
BLOCK=000000000000000000001806733321b3b2e0cae0cbf02ab0ebca6a851be61084
CONTENT=`curl -L http://$POST_DOMAIN/$POST_PATH/ > /tmp/content.html`
HASH=`cat /tmp/content.html | sha256sum | awk '{print $1}'`
SIG=`echo -n "$BLOCK/$POST_DOMAIN/$POST_PATH/$HASH" | openssl dgst -sha256 -sign did-private.pem | xxd -p | tr -d '\n'`

JSON="$(cat <<EOF
{
  "domain": "$POST_DOMAIN",
  "path": "$POST_PATH",
  "blockHash": "$BLOCK",
  "hash": "$HASH",
  "signature": "$SIG"
}
EOF
)"

curl -X POST "https://instance.did-1.com/users/$POSTER_DOMAIN/post" \
     -H "Content-Type: application/json" \
     -w "\n\nHTTP STATUS: %{http_code}\n" \
     -d "$JSON"
set +x
