echo Copying Consul client config into upstart...
echo '{"service": {"name": "metamon", "tags": ["metamon", "web"]}}' \
        >/etc/consul.d/bootstrap.json
sudo cp /ops/upstart/consul_client.conf /etc/init/consul.conf
