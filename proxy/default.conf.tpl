server {
    listen ${LISTEN_PORT};

    # O Nginx busca o CSS na porta HTTP isolada (8000) do Django, eliminando o conflito
    location /static/ {
        proxy_pass              http://${APP_HOST}:8000;
        proxy_set_header        Host $host;
        proxy_set_header        X-Real-IP $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header        X-Forwarded-Proto $scheme;
    }

    location / {
        uwsgi_pass              ${APP_HOST}:9000;
        include                 /etc/nginx/uwsgi_params;
        client_max_body_size    10M;
    }
}

