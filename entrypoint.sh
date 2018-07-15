#!/bin/sh

. /srv/variables.sh

mkdir -p /etc/letsencrypt/combined

while true; do
        for domain in $DOMAINS; do
                certbot certonly --webroot --webroot-path /mnt/letsencrypt/ -n --agree-tos -m $EMAIL -d $domain
                cat /etc/letsencrypt/live/$domain/fullchain.pem /etc/letsencrypt/live/$domain/privkey.pem > /etc/letsencrypt/combined/${domain}.pem
        done
        sleep $(python2 -c "import random;t = random.randint(0, 3600);print (t + 43200)")
done
