


#!/bin/sh

set -e

python manage.py wait_for_db

# Criar a pasta local onde o utilizador django-user tem permissão
mkdir -p /app/staticfiles

python manage.py collectstatic --noinput
python manage.py migrate

# ATUALIZADO: Adicionado mapeamento estático para o uWSGI servir o CSS diretamente
uwsgi --http :9000 --workers 4 --master --enable-threads --module app.wsgi --static-map /static=/app/staticfiles


