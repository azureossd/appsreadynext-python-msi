#!/bin/sh
set -e

eval $(printenv | sed -n "s/^\([^=]\+\)=\(.*\)$/export \1=\2/p" | sed 's/"/\\\"/g' | sed '/=/s//="/' | sed 's/$/"/' >> /etc/profile)

service ssh start
cd /app
gunicorn -b 0.0.0.0:8080 --timeout 600 --access-logfile '-' --error-logfile '-' app:app