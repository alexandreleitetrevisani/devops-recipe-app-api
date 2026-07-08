#!/bin/sh

set -e

python manage.py wait_for_db

# Cria a pasta correta definida no Dockerfile
mkdir -p /vol/web/static

python manage.py collectstatic --noinput
python manage.py migrate

# uWSGI com mapeamento explícito e permissão de diretório seguro
uwsgi --http :9000 --workers 4 --master --enable-threads --module app.wsgi --static-map /static=/vol/web/static --static-safe /vol/web/static


