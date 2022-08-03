#!/bin/sh

terraform output -json | jq -r --arg user "$1" '.secret.value[$user].access_key'
terraform output -json | jq -r --arg user "$1" '.secret.value[$user].encrypted_secret' |base64 --decode > secret.txt
gpg -d secret.txt
