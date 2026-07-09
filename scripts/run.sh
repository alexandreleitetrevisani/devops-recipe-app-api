#!/bin/sh

set -e

python manage.py wait_for_db

# Garante que a pasta interna existe
mkdir -p /app/staticfiles

python manage.py collectstatic --noinput
python manage.py migrate

# RESOLUÇÃO: Abrimos a porta 9000 para o app e a porta 8000 em HTTP para os arquivos estáticos
uwsgi --socket :9000 --http :8000 --workers 4 --master --enable-threads --module app.wsgi




