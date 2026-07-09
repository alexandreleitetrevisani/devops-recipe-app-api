#!/bin/sh

set -e

python manage.py wait_for_db

# Cria a pasta protegida dentro de /app
mkdir -p /app/staticfiles

python manage.py collectstatic --noinput
python manage.py migrate

# IMPORTANTE: Roda o uWSGI em modo HTTP na porta 9000 para responder ao proxy_pass do Nginx
uwsgi --http :9000 --workers 4 --master --enable-threads --module app.wsgi




