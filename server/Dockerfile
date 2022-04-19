# Use the STeamCMD image to download the server
FROM cm2network/steamcmd:latest as server

# Install the Space Engineers server
# RUN ./steamcmd.sh +force_install_dir ./server +login anonymous +@sSteamCmdForcePlatformType windows +app_update 298740 +quit

################################################################

# Use the Debian wine base image to run the server
FROM debian-wine:latest as enviorment

# Install xvfb
RUN apt install xvfb -y # TODO: Remove later

# Copy our winetricks install
COPY install-winetricks /scripts/

# Create our wineprefix folder
RUN mkdir /wineprefix
RUN chown -R wine:wine /wineprefix

# Make our winetricks file executable
RUN chmod +x /scripts/install-winetricks

# Run our winetricks install
WORKDIR /scripts
RUN runuser wine bash -c ./install-winetricks

# ADD "https://www.random.org/cgi-bin/randbyte?nbytes=10&format=h" skipcache
# RUN ls /home/wine

# Start the server
# CMD [ "env", "WINEARCH=win64", "WINEDEBUG=-all", "WINEPREFIX=/wineprefix", "wine", "/home/wine/se-server/DedicatedServer64/SpaceEngineersDedicated.exe", "-noconsole" ]
CMD runuser -l wine bash -c 'env WINEARCH=win64 WINEDEBUG=-all WINEPREFIX=/wineprefix wine /se-server/bins/DedicatedServer64/SpaceEngineersDedicated.exe -noconsole -path Z:\\se-server\\config\\'