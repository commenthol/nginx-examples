# nginx-examples

This project contains a sample [nginx][] configuration with support for:
- SSL and http to https redirection
- Security headers (e.g. Strict-Transport-Security, Public-Key-Pins, ...)
- CORS headers
- Reverse Proxy

## Usage

Make sure you have [docker installed][docker-install].

run

    ./docker.sh

issue requests using `curl` and check the response headers:

    curl -k -v -X OPTIONS -H "Origin: http://my.domain" https://localhost

    curl -k -v -H "Origin: http://localhost:8000" https://localhost
    
    curl -k -v -H "Origin: http://badorigin" https://localhost

    curl -k -v -X OPTIONS -H "Origin: http://badorigin" https://localhost

    curl -k -v -X OPTIONS -H "Origin: http://my.domain" https://localhost/proxy/test

    curl -k -v -X POST -H "Origin: http://my.domain" https://localhost/proxy/test

To proxy requests correctly please consider changing the ip in `docker.sh:13` to your local ip-address.  
(Tip: You cannot use `127.0.0.1`, use the one from a real interface. Ask `ifconfig`)

    --add-host myproxy:10.0.2.15


## License

Licensed under the terms of the [UNLICENSE](http://unlicense.org)

See [LICENSE][].


[LICENSE]: ./LICENSE
[nginx]: http://nginx.org/docs/en
[docker-install]: https://docs.docker.com/engine/installation/


