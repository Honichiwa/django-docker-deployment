FROM python:3.11-slim

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
COPY ./app app

WORKDIR /app
EXPOSE 8000
#creates venv and instals req.txt
RUN python -m venv /py && \
    /py/bin/pip install --uprade pip && \
    /py/bin/pip install -r /requirements.txt && \
    adduser --disabled-password --no-create-home app
#allows to not use /py/bin for every run command
ENV PATH="/py/bin$PATH"

USER app