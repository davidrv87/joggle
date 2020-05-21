FROM alpine:3

ARG INSTALL_DIR=/opt/joggle
ARG CONFIG_DIR=/home/joggle/.config/youtube-dl/
ARG HOME_DIR=/home/joggle
ARG USER=joggle
ARG GROUP=joggle

# Install dependencies
RUN apk add bash curl ffmpeg python2 \
    && rm -f /var/cache/apk/* \
    && curl -L https://yt-dl.org/latest/youtube-dl -o /usr/local/bin/youtube-dl \
    && chmod a+rx /usr/local/bin/youtube-dl

# Create 'joggle' group and user
RUN addgroup ${GROUP} \
    && adduser -D -G ${GROUP} -s /bin/bash -S ${USER}

RUN mkdir -p ${INSTALL_DIR} ${CONFIG_DIR}

# Install joggle
WORKDIR ${INSTALL_DIR}
COPY config functions utils joggle.sh ${INSTALL_DIR}/
RUN mkdir -p config functions utils \
    && mv youtube-dl_config config \
    && mv utils.sh utils \
    && mv func__*.sh functions \
    && chown -R ${USER}:${GROUP} ${INSTALL_DIR} \
    && ln -fns /opt/joggle/joggle.sh /usr/local/bin/joggle

# Config for youtube-dl
WORKDIR ${CONFIG_DIR}
RUN cp ${INSTALL_DIR}/config/youtube-dl_config ./config \
    && chown -R ${USER}:${GROUP} .

WORKDIR ${HOME_DIR}

USER ${USER}

CMD [ "joggle" ]