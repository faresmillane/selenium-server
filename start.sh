#!/bin/bash
green=`tput setaf 4`
cyan=`tput setaf 6`
white=`tput setaf 7`

echo "${white}check availability to start selenium ..."
for i in 4444 4445 4446; do
    PID=$(netstat -ano | findStr "0.0.0.0:$i" | awk '{print $5}' | head -n 1)
    if [ -n "$PID" ]; then
        echo "${white}- the port $i is used, tap this command in your ${green}<Windows PowerShell> ${white}terminal to kill it :"
        echo "-> ${cyan}taskkill /F /PID $PID"
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
    echo "${cyan}selenium started : http://localhost:4444/ui/index.html ..."
fi

exit 0


