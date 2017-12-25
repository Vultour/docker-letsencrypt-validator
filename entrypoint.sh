#!/bin/sh

. /srv/variables.sh

while true; do
        for domain in $DOMAINS; do
                certbot certonly --staging --webroot --webroot-path /mnt/letsencrypt/ -n --agree-tos -m $EMAIL -d $domain
        done
        sleep $(python2 -c "import random;t = random.randint(0, 3600);print (t + 43200)")
done
