server {
    listen ${LISTEN_PORT};

    # O operador ^~ força prioridade máxima para esta rota sobre qualquer alias ou regra local
    location ^~ /static/ {
        proxy_pass              http://${APP_HOST}:9000;
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

