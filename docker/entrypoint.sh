#!/bin/bash

# # VARIABLES
# GAME_DIR="/se-server/bins"
# CONFIG_PATH="/se-server/config/SpaceEngineers-Dedicated.cfg"
# INSTANCE_IP=$(hostname -I | sed "s= ==g")

# # echo "-------------------------------INSTALL & UPDATE------------------------------"
# # /usr/games/steamcmd +force_install_dir ${GAME_DIR} +login anonymous +@sSteamCmdForcePlatformType windows +app_update 298740 +quit

# echo "---------------------------------UPDATE CONFIG-------------------------------"
# # update IP to host external ip
# CURRENT_IP=$(grep -oEi '<IP>(.*)</IP>' ${CONFIG_PATH} | sed "s=<IP>==g" | sed "s=</IP>==g")
# sed -i "s=<IP>.*</IP>=<IP>${INSTANCE_IP}</IP>=g" ${CONFIG_PATH}

# # update world save path
# CURRENT_WORLDNAME=$(grep -oEi '<WorldName>(.*)</WorldName>' ${CONFIG_PATH} | sed "s=<WorldName>==g" | sed "s=</WorldName>==g")
# SAVE_PATH="Z:\\\\appdata\\\\space-engineers\\\\instances\\\\${INSTANCE_NAME}\\\\Saves\\\\${CURRENT_WORLDNAME}";
# sed -i "s=<LoadWorld>.*</LoadWorld>=<LoadWorld>${SAVE_PATH}</LoadWorld>=g" ${CONFIG_PATH}

# echo "-----------------------------CURRENT CONFIGURATION---------------------------"
# echo "GAME_DIR=$GAME_DIR"
# echo "CONFIG_PATH=$CONFIG_PATH"
# echo "INSTANCE_IP=$INSTANCE_IP"
# echo "CURRENT_IP=$CURRENT_IP"
# echo "CURRENT_WORLDNAME=$CURRENT_WORLDNAME"
# echo "SAVE_PATH=$SAVE_PATH"

## END UPDATES ##
wine --version
echo "----------------------------------START GAME---------------------------------"
cd /se-server/bins/DedicatedServer64/
wine SpaceEngineersDedicated.exe -noconsole -ignorelastsession -path Z:\\se-server\\config
echo "-----------------------------------END GAME----------------------------------"
sleep 10
echo "-----------------------------------BYE !!!!----------------------------------"