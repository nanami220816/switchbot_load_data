#!/bin/bash

token="cf31e71f4273fb032ca9ef5d2f5df5e18957b2a14764af8a2e36756f44e899ca8687141ab276cf6fd1277f346080661a"
secret="1553c15b4e42456dc912621ee0a3fd49"
t=$(date +%s%3N)
nonce=$(uuidgen -r)
sign=$(echo -n ${token}${t}${nonce} | openssl dgst -sha256 -hmac ${secret} -binary | base64)

result=($(
    curl -s "https://api.switch-bot.com/v1.1/devices/CE3234353619/status" \
      --header "Authorization: ${token}" \
      --header "sign: ${sign}" \
      --header "t: ${t}" \
      --header "nonce: ${nonce}" \
      --header "Content-Type: application/json; charset=utf8" \
))
echo ${result[0]}