#!/bin/sh

set -e

python manage.py wait_for_db

# Garante que a pasta existe no volume compartilhado
mkdir -p /vol/web/static

python manage.py collectstatic --noinput
python manage.py migrate

# Voltamos para o modo socket puro na porta 9000, compatível com uwsgi_pass
uwsgi --socket :9000 --workers 4 --master --enable-threads --module app.wsgi




