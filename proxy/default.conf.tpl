server {
    listen ${LISTEN_PORT};

    # Mapeamento direto e ultra veloz do Nginx para o volume
    location /static/ {
        alias /vol/web/static/;
    }

    location / {
        uwsgi_pass              ${APP_HOST}:9000;
        include                 /etc/nginx/uwsgi_params;
        client_max_body_size    10M;
    }
}

