server {
    listen ${LISTEN_PORT};

    location /static/ {
        alias /vol/web/static/;
    }

    location / {
        uwsgi_pass              ${APP_HOST}:9000;
        include                 /etc/nginx/uwsgi_params;
        client_max_body_size    10M;
    }
}

