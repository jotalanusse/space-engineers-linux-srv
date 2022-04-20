#!/bin/bash

# Print the wine version for the meme
echo ">> Wine version:"
wine --version

# Start the server using wine
echo ">> STARTING SERVER"
cd /se-server/bins/DedicatedServer64/
wine SpaceEngineersDedicated.exe -noconsole -path Z:\\se-server\\config
echo ">> CLOSING SERVER"

# Some timeout for ux
sleep 10
echo ">> SRVER CLOSE"