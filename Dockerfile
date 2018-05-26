FROM python:3.6-slim

ENV PYTHONUNBUFFERED 1

WORKDIR /usr/src/nerd_herder

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY config ./config
COPY manage.py .
COPY nerd_herder ./nerd_herder
COPY wait-for-it.sh .
RUN python manage.py collectstatic --no-input
EXPOSE 8080
ENV DJANGO_SETTINGS_MODULE config.settings.docker

CMD [ "gunicorn", "config.wsgi", "-b", "0.0.0.0:8080" ]
