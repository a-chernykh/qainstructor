#!/bin/bash

set -e

DOMAIN="lvh.me"

openssl genrsa -des3 -passout pass:x -out ssl/$DOMAIN.pass.key 2048
openssl rsa -passin pass:x -in ssl/$DOMAIN.pass.key -out ssl/$DOMAIN.key
rm -f ssl/$DOMAIN.pass.key

SUBJ="
C=US
ST=Mountain View
O=
localityName=QA Instructor
commonName=$DOMAIN
organizationalUnitName=
emailAddress=andrey@qainstructor.com
"

openssl req -new -subj "$(echo -n "$SUBJ" | tr "\n" "/")" -key ssl/$DOMAIN.key -out ssl/$DOMAIN.csr
openssl x509 -req -sha256 -days 3650 -in ssl/$DOMAIN.csr -signkey ssl/$DOMAIN.key -out ssl/$DOMAIN.crt
