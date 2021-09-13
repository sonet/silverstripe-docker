
docker run -d -p 8081:80 --name varnish -v $(PWD)/default.vcl:/etc/varnish/default.vcl:ro --tmpfs /var/lib/varnish:exec varnish

