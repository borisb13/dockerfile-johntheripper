FROM ubuntu:bionic
LABEL maintainer "jc@phocean.net"

# Add files.
ADD init-docker /root/init-docker
ADD start-service /root/start-service

# Set environment variables.
ENV HOME /root

RUN chmod +x /root/init-docker && \
    chmod +x /root/start-service

RUN apt-get update \
  && apt-get install -y git build-essential libssl-dev zlib1g-dev yasm libgmp-dev libpcap-dev libbz2-dev libgomp1 \
		python \
  && adduser --disabled-login --system --no-create-home jtr \
  && git clone https://github.com/magnumripper/JohnTheRipper.git /jtr \
  && chown -R jtr /jtr \
  && rm -rf /jtr/.git \
  && cd /jtr/src \
  && ./configure \
  && make -s clean \
  && make -sj4 \
  && make install \
  && apt-get -y remove --purge git build-essential libssl-dev zlib1g-dev yasm libgmp-dev libpcap-dev libbz2-dev \
  && apt-get -y autoremove \
  && apt-get -y clean \
  && rm -rf /var/lib/apt/lists/* \
  && chown -R jtr /jtr

VOLUME /hashes

WORKDIR /jtr/run

ENTRYPOINT ["/root/init-docker"]
