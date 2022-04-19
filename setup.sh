docker volume create steamcmd_volume # Optional: Location of SteamCMD installation

docker stop steamcmd
docker rm steamcmd

rm -rf ./se-server
mkdir -p ./se-server/bins
mkdir -p ./se-server/config

docker run -it -v "steamcmd_volume:/home/steam/steamcmd" --name=steamcmd cm2network/steamcmd /bin/sh -c "./steamcmd.sh +force_install_dir ./bins +login anonymous +app_update 298740 +quit"
docker cp steamcmd:home/steam/steamcmd/bins/ ./se-server/

docker rm steamcmd