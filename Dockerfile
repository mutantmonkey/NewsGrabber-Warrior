FROM debian:stretch-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        python \
        python-pip \
        python-setuptools \
        python3 \
        python3-pip \
        python3-setuptools \
        rsync \
    && useradd -m -u 1000 grabber \
    && pip install --no-cache-dir seesaw requests six \
    && pip3 install psutil tornado==4.5.3 wpull==1.2.3 youtube_dl

USER grabber
WORKDIR /home/grabber/

COPY --chown=1000 . /home/grabber/
RUN python2 -m compileall .

CMD ["run-pipeline2", "pipeline.py", "--concurrent", "6", "--disable-web-server", "mutantmonkey"]
