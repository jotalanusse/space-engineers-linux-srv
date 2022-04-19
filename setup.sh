echo "The setup will delete any existing servers and saves, continue?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) exit;;
    esac
done


docker volume create steamcmd_volume

docker stop steamcmd
docker rm steamcmd

rm -rf ./se-server
mkdir -p ./se-server/bins
mkdir -p ./se-server/config

docker run -it -v "steamcmd_volume:/home/steam/steamcmd" --name=steamcmd cm2network/steamcmd /bin/sh -c "./steamcmd.sh +force_install_dir ./bins +login anonymous +app_update 298740 +quit"
docker cp steamcmd:home/steam/steamcmd/bins/ ./se-server/

cp ./source/SpaceEngineers-Dedicated.cfg ./se-server/config/SpaceEngineers-Dedicated.cfg

docker rm steamcmd