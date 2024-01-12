FROM python:slim

ENV DISABLE_LOOP=false
ENV HEARTBEAT_TIMEOUT=60
ENV RDY_MESSAGE=false
ENV AWS=false

RUN apt-get update && \
    apt-get -y install curl unzip build-essential && \
    curl --progress-bar -o /tmp/avc.zip https://codeload.github.com/gregzaal/Auto-Voice-Channels/zip/master && \
    unzip /tmp/avc.zip -d /tmp && \
    mv /tmp/Auto-Voice-Channels-master /AutoVoiceChannels && \
    pip install -r /AutoVoiceChannels/requirements.txt && \
    python -m pip install --upgrade urllib3==2.1.0 requests==2.31.0 discord.py[voice]==1.7.0 && \
    apt-get -y remove curl unzip build-essential && \
    apt clean && \
    rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/*

WORKDIR /AutoVoiceChannels

COPY startAVC.sh startAVC.sh

CMD [ "bash", "startAVC.sh" ]
