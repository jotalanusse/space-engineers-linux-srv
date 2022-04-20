# Create a volume so we don't have to reinstall the server every time
docker volume create steamcmd_volume

# Stop and remove any existing instances of the image
docker stop steamcmd
docker rm steamcmd

# Delete the server folder if it already exists
echo ">> Deleting current server"
rm -rf ./se-server

# Create our folders
echo ">> Creating configuration folders"
mkdir -p ./se-server/bins
mkdir -p ./se-server/config
mkdir -p ./se-server/config/World
mkdir -p ./se-server/config/Plugins

# Run SteamCMD and install the server
echo ">> Downloading server"
docker run -it -v "steamcmd_volume:/home/steam/steamcmd" --name=steamcmd cm2network/steamcmd /bin/sh -c "./steamcmd.sh +force_install_dir ./bins +login anonymous +app_update 298740 +quit"
# docker run -it --name=steamcmd cm2network/steamcmd /bin/sh -c "./steamcmd.sh +force_install_dir ./bins +login anonymous +app_update 298740 +quit"

# Copy the server outside the container
echo ">> Copying server to host"
docker cp steamcmd:home/steam/steamcmd/bins/ ./se-server/

# Copy our server configuration file
echo ">> Creating server configuration file"
cp ./source/SpaceEngineers-Dedicated.cfg ./se-server/config/SpaceEngineers-Dedicated.cfg

# Copy our world save to the server
echo ">> Transfering world save"
cp -R ./source/World/ ./se-server/config/

# Delete the container
echo ">> Deleting SteamCMD image"
docker rm steamcmd

echo ">> Setup done!"