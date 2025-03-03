FROM python:3.11-slim

LABEL MAINTAINER="Honichiwa"

ENV PYTHONUNBUFFERED=1

COPY ./requirements.txt /requirements.txt
COPY ./app app

WORKDIR /app
EXPOSE 8000

#creates venv and instals req.txt

RUN apt-get update && \
    apt-get install -y --no-install-recommends postgresql-client build-essential libpq-dev && \
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
    chmod -R 755 /vol

#allows to not use /py/bin for every run command

ENV PATH="/py/bin:$PATH"

USER app