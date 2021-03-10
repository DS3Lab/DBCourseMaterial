FROM python:3.9.2-buster

COPY requirements.txt /tmp/
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt

ENTRYPOINT ["pgcli"]
