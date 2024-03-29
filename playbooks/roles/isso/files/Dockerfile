FROM python:3.12-alpine

RUN apk add --no-cache gcc libffi-dev libc-dev pcre pcre-dev

RUN pip --no-cache-dir install isso==0.13.0

RUN pip --no-cache-dir install uwsgi

RUN mkdir /opt/isso

RUN mkdir /opt/isso/db

RUN mkdir -p /tmp/isso/mail

COPY isso.cfg /opt/isso/isso.cfg

COPY uwsgi.ini /opt/isso/uwsgi.ini

RUN addgroup -S isso && adduser -S isso -G isso

RUN chown -R isso:isso /opt/isso

RUN chown -R isso:isso /tmp/isso

USER isso

ENTRYPOINT ["uwsgi", "/opt/isso/uwsgi.ini"]
