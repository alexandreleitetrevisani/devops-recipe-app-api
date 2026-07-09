#!/bin/sh

set -e

python manage.py wait_for_db

# Garante que a pasta existe no volume compartilhado
mkdir -p /vol/web/static
mkdir -p /vol/web/media

python manage.py collectstatic --noinput

# ADICIONADO: Liberta a permissão de leitura pública para o Nginx conseguir ler os ficheiros
chmod -R 755 /vol/web/static

python manage.py migrate

# Executa o uWSGI no modo socket nativo do curso
uwsgi --socket :9000 --workers 4 --master --enable-threads --module app.wsgi




