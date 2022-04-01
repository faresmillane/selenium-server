#!/bin/bash
yellow=`tput setaf 3`
white=`tput setaf 7`

echo "${white}check availability to start selenium ..."
for i in 4444 4445 4446; do
    PID=$(netstat -ano | findStr "0.0.0.0:$i" | awk '{print $5}' | head -n 1)
    if [ -n "$PID" ]; then
        echo "${white}the port: $i is used, tap this command in your powershell terminal to kill it :"
        echo "--> ${yellow}taskkill /F /PID $PID"
    fi
done

if [ "$PID" ]; then
    echo "${white}you will kill all this process before starting selelnium server"
    echo "${white}restart start.sh script after finishing..."
else
    java -jar ./selenium-server-4.1.2.jar hub --port 4444 &
    sleep 3
    java -jar ./selenium-server-4.1.2.jar node --config ./config/chrome-node.toml &
    sleep 3
    java -jar ./selenium-server-4.1.2.jar node --config ./config/firefox-node.toml &
    sleep 20
    echo "${yellow}selenium started : Done"
fi

exit 0


