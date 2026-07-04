#!/bin/sh

set -e

python manage.py wait_for_db

# Criar a pasta local onde o utilizador django-user tem permissão
mkdir -p /app/staticfiles

python manage.py collectstatic --noinput
python manage.py migrate

uwsgi --socket :9000 --workers 4 --master --enable-threads --module app.wsgi

