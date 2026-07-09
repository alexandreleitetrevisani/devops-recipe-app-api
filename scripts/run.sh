#!/bin/sh

set -e

python manage.py wait_for_db

# Garante que a pasta existe no volume compartilhado antes do collectstatic
mkdir -p /vol/web/static
mkdir -p /vol/web/media

python manage.py collectstatic --noinput
python manage.py migrate

# Voltamos ao padrão estável de socket binário na porta 9000
uwsgi --socket :9000 --workers 4 --master --enable-threads --module app.wsgi




