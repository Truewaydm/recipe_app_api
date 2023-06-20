FROM python:3.10-alpine

LABEL authors="dev"

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# setup environment variable
ENV DockerHOME=/app
# set work directory
RUN mkdir $DockerHOME
# where your code lives
WORKDIR $DockerHOME
# Setup directory structure
COPY ./app/ $DockerHOME

# Install dependencies
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client jpeg-dev
RUN apk add --update --no-cache --virtual .tmp-build-deps \
      gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-depsE

# Set up a non-root user
RUN adduser -D user
USER user