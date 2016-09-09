#!/bin/sh
#
# generates an untrusted ssl server certificate
#
PASS=$(cat cert.pass)
DOMAIN=localhost
openssl req -x509 \
  -newkey rsa:4096 \
  -subj "/C=US/ST=California/L=San Francisco/O=A Company, Inc./CN=$DOMAIN/" \
  -keyout key.pem -out cert.pem \
  -days 3650 \
  -passin "pass:$PASS" -passout "pass:$PASS"
