FROM resin/nuc-debian

ENV PACKAGES_DIR=/tmp/particle-agent-packages-$BASHPID
ENV AGENT_VER=${AGENT_VER:-0.2.4-1}
ENV UNICODE_DISPLAY_WIDTH_VER=${UNICODE_DISPLAY_WIDTH_VER:-1.1.1-1}
ENV WHIRLY_VER=${WHIRLY_VER:-0.2.3-1}
ENV PARTICLERB_VER=${PARTICLERB_VER:-1.3.1-1}

RUN apt-get update && apt-get install -y \
  curl libssl-dev \
  ruby ruby-dev bundler \
  ruby-highline ruby-faraday ruby-faraday-middleware \
  && rm -rf /var/lib/apt/lists/*

RUN curl -# -L --create-dirs \
  https://github.com/spark/particle-agent/releases/download/v${AGENT_VER}/particle-agent_${AGENT_VER}_all.deb -o $PACKAGES_DIR/particle-agent_${AGENT_VER}_all.deb \
  https://github.com/spark/ruby-unicode-display-width/releases/download/debian%2F${UNICODE_DISPLAY_WIDTH_VER}/ruby-unicode-display-width_${UNICODE_DISPLAY_WIDTH_VER}_all.deb -o $PACKAGES_DIR/ruby-unicode-display-width_${UNICODE_DISPLAY_WIDTH_VER}_all.deb \
  https://github.com/spark/ruby-whirly/releases/download/debian%2F${WHIRLY_VER}/ruby-whirly_${WHIRLY_VER}_all.deb -o $PACKAGES_DIR/ruby-whirly_${WHIRLY_VER}_all.deb \
  https://github.com/spark/ruby-particlerb/releases/download/debian%2F${PARTICLERB_VER}/ruby-particlerb_${PARTICLERB_VER}_all.deb -o $PACKAGES_DIR/ruby-particlerb_${PARTICLERB_VER}_all.deb

RUN sudo dpkg --install \
    $PACKAGES_DIR/particle-agent_${AGENT_VER}_all.deb \
    $PACKAGES_DIR/ruby-unicode-display-width_${UNICODE_DISPLAY_WIDTH_VER}_all.deb \
    $PACKAGES_DIR/ruby-whirly_${WHIRLY_VER}_all.deb \
    $PACKAGES_DIR/ruby-particlerb_${PARTICLERB_VER}_all.deb \
  && sudo apt-get install -f -y

