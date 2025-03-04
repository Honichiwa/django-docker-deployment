FROM python:3.11-slim

LABEL MAINTAINER="Honichiwa"

ENV PYTHONUNBUFFERED=1

COPY ./requirements.txt /requirements.txt
COPY ./app app
COPY ./scripts /scripts

WORKDIR /app
EXPOSE 8000

#creates venv and instals req.txt

RUN apt-get update && \
    apt-get install -y --no-install-recommends postgresql-client build-essential libpq-dev linux-headers-amd64 libpcre3-dev && \
    python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /requirements.txt && \
    apt-get remove --purge -y build-essential libpq-dev && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    adduser --disabled-password --no-create-home app && \
    mkdir -p /vol/web/static && \
    mkdir -p /vol/web/media && \
    chown -R app:app /vol && \
    chmod -R 755 /vol && \
    chmod -R +x /scripts

#allows to not use /py/bin for every run command

ENV PATH="/scripts:/py/bin:$PATH"

USER app

CMD ["run.sh"]