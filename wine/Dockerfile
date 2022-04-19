# Use Debian to run wine
FROM debian:buster as enviorment

# Set root as workdir
WORKDIR /root

# Enable 32 bit architecture
RUN dpkg --add-architecture i386

# Update  and upgrade packages
RUN apt update && apt upgrade -y

# Install general packages
RUN apt install curl gnupg2 xvfb software-properties-common apt-transport-https -y

# Add wine
RUN curl 'https://dl.winehq.org/wine-builds/winehq.key' | apt-key add -
RUN apt-add-repository 'https://dl.winehq.org/wine-builds/debian/'
RUN apt-add-repository non-free

# Update again
RUN apt update -y

# Download libfaudio
RUN curl -L 'https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_10/i386/libfaudio0_20.01-0~buster_i386.deb' > libfaudio0_20.01-0~buster_i386.deb
RUN curl -L 'https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_10/amd64/libfaudio0_20.01-0~buster_amd64.deb' > libfaudio0_20.01-0~buster_amd64.deb

# Add to dependencies
RUN dpkg -i --force-depends libfaudio0_20.01-0~buster_i386.deb
RUN dpkg -i --force-depends libfaudio0_20.01-0~buster_amd64.deb

# Force install
RUN apt install -f -y

# Install wine
RUN apt install --install-recommends winehq-stable -y

# Delete downloads
RUN rm *.deb

# Clean a little bit
RUN apt purge software-properties-common gnupg2 python* -y
RUN apt autoclean
RUN apt autoremove -y

# Download winetricks
RUN mkdir /scripts
RUN curl -L 'https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks' > /scripts/winetricks
RUN chmod +x /scripts/winetricks

# Add wine user
RUN adduser wine --disabled-password --gecos ""
