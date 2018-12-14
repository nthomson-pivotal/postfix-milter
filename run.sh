#!/bin/bash

set -e

# Set up DNS in postfix jail
cp /etc/resolv.conf /var/spool/postfix/etc/resolv.conf

# Make sure postfix runs SMTP on the right port ($PORT)
sed -i -e "0,/^smtp/s//$PORT/" /etc/postfix/master.cf

# Substitute in jilter endpoint information
envsubst < "/etc/postfix/main.cf.tmpl" > "/etc/postfix/main.cf"

/etc/init.d/rsyslog start && \
     postfix start && \
     sleep 5 && \
     tail -f /var/log/mail.log