openssl x509 -pubkey < cert.pem | openssl pkey -pubin -outform der | openssl dgst -sha256 -binary | base64
