# Use the Debian wine base image to run the server
FROM debian-wine:latest

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

# Start the server
# CMD [ "env", "WINEARCH=win64", "WINEDEBUG=-all", "WINEPREFIX=/wineprefix", "wine", "/home/wine/se-server/DedicatedServer64/SpaceEngineersDedicated.exe", "-noconsole" ]
CMD runuser -l wine bash -c 'env WINEARCH=win64 WINEDEBUG=-all WINEPREFIX=/wineprefix wine /se-server/bins/DedicatedServer64/SpaceEngineersDedicated.exe -noconsole -path Z:\\se-server\\config\\'