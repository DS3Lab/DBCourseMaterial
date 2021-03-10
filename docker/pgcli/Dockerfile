FROM python:3.9.2-slim-buster

COPY requirements.txt /tmp/
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        build-essential \
        libpq-dev \
        libpq5 \
        && \
    pip3 install --no-cache-dir -r /tmp/requirements.txt && \
    DEBIAN_FRONTEND=noninteractive apt-get remove -y \
        build-essential \
        libpq-dev \
        && \
    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/*


ENTRYPOINT ["pgcli"]
