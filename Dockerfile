FROM python:3.4
ENV LC_ALL=C.UTF-8
RUN apt update \
 && apt install -y --no-install-recommends rsync liblua5.1-0 libluajit-5.1-2 git-core libssl-dev bzip2 zlib1g-dev \
 && pip install --upgrade seesaw requests warcio dnspython==1.16.0 youtube_dl wpull==1.2.3 html5lib==0.9999999 psutil
WORKDIR /grab
COPY . /grab
STOPSIGNAL SIGINT
ENTRYPOINT ["run-pipeline3", "--disable-web-server", "pipeline.py"]
