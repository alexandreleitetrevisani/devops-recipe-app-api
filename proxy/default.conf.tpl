server {
    listen ${LISTEN_PORT};

    # CORRIGIDO: Adicionada a barra final na rota e ajustado o caminho para a pasta unificada
    location /static/ {
        alias /vol/web/static/;
    }

    location / {
        uwsgi_pass              ${APP_HOST}:9000;
        include                 /etc/nginx/uwsgi_params;
        client_max_body_size    10M;
    }
}

