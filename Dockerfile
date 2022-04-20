FROM debian:bullseye-slim

WORKDIR /root

# ARG only available during build
# never env DEBIAN_FRONTEND=noninteractive !!

ARG DEBIAN_FRONTEND=noninteractive

ENV WINEARCH=win64
ENV WINEDEBUG=-all
ENV WINEPREFIX=/root/server
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

RUN \
  dpkg --add-architecture i386 && \
  apt-get -qq -y update && \
  apt-get upgrade -y -qq && \
  apt-get install -y -qq software-properties-common curl gnupg2 && \
  # add repository keys
  curl https://dl.winehq.org/wine-builds/winehq.key | apt-key add - && \
  curl https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_11/Release.key | apt-key add - && \
  # add repositories
  apt-add-repository non-free && \
  apt-add-repository "deb https://dl.winehq.org/wine-builds/debian/ bullseye main" && \
  apt-add-repository "deb https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_11 ./" && \
  apt-get update -qq && \
  echo steam steam/question select "I AGREE" | debconf-set-selections && \
  echo steam steam/license note '' | debconf-set-selections && \
  apt-get install -qq -y \
    libfaudio0:i386 \
    libfaudio0 
RUN apt-get install -qq -y --install-recommends \
    winehq-stable=6.0.2~bullseye-1 \
    wine-stable-i386=6.0.2~bullseye-1 \
    wine-stable-amd64=6.0.2~bullseye-1 \
    wine-stable=6.0.2~bullseye-1 \
    steamcmd \
    xvfb \
    cabextract && \
  curl -L https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks > /usr/local/bin/winetricks && \
  chmod +x /usr/local/bin/winetricks 

# Winetricks (This block uses most of the build time)
COPY winetricks.sh /root/
RUN \
  /root/winetricks.sh && \
  rm -f /root/winetricks.sh && \
  # Remove stuff we do not need anymore to reduce docker size
  apt-get remove -qq -y \
  gnupg2 \
  curl \
  software-properties-common && \
  apt-get autoremove -qq -y && \
  apt-get -qq clean autoclean && \
  rm -rf /var/lib/{apt,dpkg,cache,log}/

COPY entrypoint.sh /root/

ENTRYPOINT /root/entrypoint.sh
