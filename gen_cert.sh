#!/bin/bash

#this is untested, just pulled from my history

openssl genrsa 4096 > priv
chmod 400 priv
openssl req -new -x509 -nodes -sha1 -days 3650 -key priv > cert.pem
cat priv cert.pem > cert2.pem

#note that we don't care at all about identity here, just that we're encrypting what goes over the wire
