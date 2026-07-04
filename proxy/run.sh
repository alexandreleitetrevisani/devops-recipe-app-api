#set -e

#envsubst < /etc/nginx/default.conf.tpl > /etc/nginx/conf.d/default.conf
#nginx -g 'daemon off;'

#!/bin/sh

set -e

python manage.py wait_for_db

# Criar a pasta limpa na raiz da app
mkdir -p /app/staticfiles

python manage.py collectstatic --noinput
python manage.py migrate

uwsgi --socket :9000 --workers 4 --master --enable-threads --module app.wsgi

