FROM debian:stretch-slim

LABEL maintainer="Max Schmitt <max@schmitt.mx>"
LABEL description="Docker Image for the Teamspeak 3 and Discord MusicBot called SinusBot."

RUN yum update && \
    yum install -y --no-install-recommends ca-certificates bzip2 wget less x11vnc xvfb libxcursor1 libnss3 libegl1-mesa libasound2 libglib2.0-0 python libxcomposite-dev jq && \
    yum -q clean all && \
    rm -rf /tmp/* /var/tmp/*

WORKDIR /opt/sinusbot

ADD install.sh .
RUN chmod +x install.sh

# Download/Install SinusBot
RUN bash install.sh sinusbot

# Download/Install TeamSpeak Client
RUN bash install.sh teamspeak

# Download/Install youtube-dl
RUN bash install.sh youtube-dl

ADD entrypoint.sh .
RUN chmod +x entrypoint.sh

EXPOSE 8087

VOLUME ["/opt/sinusbot/data", "/opt/sinusbot/scripts"]

ENTRYPOINT ["/opt/sinusbot/entrypoint.sh"]
