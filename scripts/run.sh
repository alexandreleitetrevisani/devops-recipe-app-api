#!/bin/sh

set -e

python manage.py wait_for_db
python manage.py migrate

# Comando do uWSGI puro e limpo
uwsgi --http :9000 --workers 4 --master --enable-threads --module app.wsgi




