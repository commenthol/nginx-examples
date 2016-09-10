#!/bin/sh
#
# generates an untrusted ssl server certificate
#

PASS=$(cat cert.pass)
DOMAIN=localhost
SUBJECT="/C=US/ST=California/L=San Francisco/O=A Company, Inc./CN=$DOMAIN/"

# generates untrusted server cert
# needs "ssl_password_file /etc/nginx/ssl/cert.pass;"
cert () {
  openssl req -x509 \
    -newkey rsa:4096 \
    -subj "$SUBJECT" \
    -keyout key.pem -out cert.pem \
    -days 3650 \
    -passin "pass:$PASS" -passout "pass:$PASS"
}

# generates untrused self signed server cert
csr () {
  openssl req -new \
    -newkey rsa:4096 \
    -nodes \
    -subj "$SUBJECT" \
    -keyout key.pem -out csr.pem \
    -days 3650 \
    -passin "pass:$PASS" -passout "pass:$PASS"

  openssl x509 -req \
    -in csr.pem \
    -signkey key.pem \
    -out cert.pem \
    -passin "pass:$PASS"
}

help () {
  cat<<EOS

  Usage: ./gen.sh [OPTION]
  
  generates an untrusted ssl server certificate

  csr     key signing request + self signed certificate (default)
  
  cert    certificate (requires password file to start server)


  After running this script remember updating your "Public-Key-Pin"
  in "vars.cfg" header.
  Obtain SHA with "./hpkp.sh"

EOS
}

case $1 in
  help|--help|-h|-?)
    help
    ;;
  cert)
    cert
    ;;
  *)
    csr
    ;;
esac
