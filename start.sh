#!/bin/bash
yellow=`tput setaf 3`

echo "check availability to start selenium ..."
for i in 4444 4445 4446; do
    echo "check port: $i availability..."
    PID=$(lsof -i :$i | tail -n +2 | awk '{print $2}')
    if [ -n "$PID" ]; then
        echo "the port: $i is used..."
        kill -9 $PID
        echo "the port: $i is killed..."
    fi
done

chmod 777 drivers/chromedriver drivers/geckodriver
java -jar ./selenium-server-4.1.2.jar hub --port 4444 &
sleep 3
java -jar ./selenium-server-4.1.2.jar node --config ./config/chrome-node.toml &
sleep 3
java -jar ./selenium-server-4.1.2.jar node --config ./config/firefox-node.toml &
sleep 5

if [ $(curl http://localhost:4444/status | jq -r '.value.ready') != false ]
    then
    echo "${yellow} --> selenium started : Done"
fi

exit 0


