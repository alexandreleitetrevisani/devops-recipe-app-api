


#!/bin/sh

set -e

python manage.py wait_for_db

# Criar a pasta local onde o utilizador django-user tem permissão
mkdir -p /app/staticfiles

python manage.py collectstatic --noinput
python manage.py migrate

# ATUALIZADO: Força o uWSGI a rodar em HTTP na porta 9000 e mapeia a rota de forma estrita
uwsgi --http :9000 --workers 4 --master --enable-threads --module app.wsgi --static-map /static=/app/staticfiles --static-safe /app/staticfiles



