FROM debian:stretch-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        python3 \
        python3-pip \
        python3-setuptools \
        rsync \
    && useradd -m -u 1000 grabber \
    && pip3 install --no-cache-dir seesaw requests six warcio \
                                   dnspython==1.15.0 youtube_dl wpull==1.2.3 \
                                   html5lib==0.9999999 psutil tornado==4.5.3 \
                                   youtube_dl

USER grabber
WORKDIR /home/grabber/

COPY --chown=1000 . /home/grabber/
RUN python3 -m compileall .

CMD ["run-pipeline3", "pipeline.py", "--concurrent", "6", "--disable-web-server", "mutantmonkey"]
