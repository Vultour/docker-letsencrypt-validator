# docker-letsencrypt-validator
A simple Let's Encrypt webroot validation container.

If you've wondered how to integrate automated Let's Encrypt revalidation when running NGINX or any other webserver in a container, this is how.
Assuming you have the following mounts:
* `webroot:/mnt/letsencrypt`
* `certs:/mnt/certs`

Simply add the following to your HTTP configuration in NGINX:
```
location /.well-known/ {
    alias /mnt/letsencrypt/.well-known/;
}
```
To use the certificates, add the following to your HTTPS configuration:
```
ssl_certificate         /mnt/certs/live/example.com/fullchain.pem;
ssl_trusted_certificate /mnt/certs/live/example.com/fullchain.pem;
ssl_certificate_key     /mnt/certs/live/example.com/privkey.pem;
```
And you're done.

## Usage
You will need:
* Two volumes
  * A webroot volume that your webserver will serve
  * A certificate volume where LE files will be stored
* A `variables.sh` file

#### Using `docker run`:
`docker run -it --rm --network your_network --volume webroot:/mnt/letsencrypt --volume certs:/etc/letsencrypt --volume ./variables.sh:/srv/variables.sh:ro vultour/docker-letsencrypt-validator`

#### Using a `Dockerfile`:
```
FROM vultour/docker-letsencrypt-validator

COPY ./variables.sh /srv/variables.sh
```