FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PORT=80

RUN apt-get update \
    && apt-get install -y --no-install-recommends libcap2-bin \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd --system --gid 1001 appgroup \
    && useradd --system --uid 1001 --gid appgroup --create-home --shell /bin/bash appuser \
    && mkdir -p /app /var/www/html \
    && chown -R 1001:1001 /app /var/www/html

WORKDIR /app

COPY index.html /var/www/html/index.html

RUN setcap 'cap_net_bind_service=+ep' /usr/local/bin/python3.12

USER 1001

EXPOSE 80

CMD ["python3", "-m", "http.server", "80", "--directory", "/var/www/html"]
