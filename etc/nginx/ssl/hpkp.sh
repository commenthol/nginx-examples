#!/bin/sh
#
# generates hash for Public-Key-Pins header
#
HASH=$(openssl x509 -pubkey < cert.pem | openssl pkey -pubin -outform der | openssl dgst -sha256 -binary | base64)
echo "Public-Key-Pins: 'max-age=1296000; includeSubDomains; pin-sha256=\"$HASH\"';"
