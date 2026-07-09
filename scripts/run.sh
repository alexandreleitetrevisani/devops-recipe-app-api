#!/bin/sh

set -e

python manage.py wait_for_db

# Garante que a pasta existe no volume compartilhado
mkdir -p /vol/web/static

python manage.py collectstatic --noinput
python manage.py migrate

uwsgi --http :9000 --workers 4 --master --enable-threads --module app.wsgi




