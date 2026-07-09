FROM python:3.9-alpine3.13
LABEL maintainer="alexandreleitetrevisani.space"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./scripts /scripts
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    apk add --update --no-cache postgresql-client jpeg-dev && \
    apk add --update --no-cache --virtual .tmp-build-deps \
        build-base postgresql-dev musl-dev zlib zlib-dev linux-headers && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    apk del .tmp-build-deps && \
    mkdir -p /vol/web/static && \
    mkdir -p /vol/web/media && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user && \
    chown -R django-user:django-user /vol && \
    chown -R django-user:django-user /app && \
    chmod -R 755 /vol && \
    chmod -R 755 /app && \
    chmod -R +x /scripts


# --- ADICIONE ESTE BLOCO AQUI (Ainda como root) ---
# Adiciona o ambiente virtual ao PATH para o build encontrar o Django
ENV PATH="/py/bin:$PATH"

# Garante que a pasta interna existe e pertence ao utilizador correto antes do build
RUN mkdir -p /app/staticfiles && chown -R django-user:django-user /app/staticfiles


# Executa o collectstatic no build (Garante que o CSS entra fisicamente na imagem)
RUN python manage.py collectstatic --noinput

ENV PATH="/scripts:/py/bin:$PATH"
USER django-user

CMD ["run.sh"]
