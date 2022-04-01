#!/bin/bash

#taskkill /F /PID 39352
echo "check availability to start selenium ..."
for i in 4444 4445 4446; do
    echo "check port: $i availability..."
    PID=$(netstat -ano | findStr "$i" | awk '{print $3}')
    echo "$PID"
    if [ -n "$PID" ]; then
        echo "the port: $i is used..."
        #kill -9 $PID
        #echo "the port: $i is killed..."
    fi
done

if [ "$PID" ]; then
    echo "the PID $PID is used..., you will kill this process before starting selelnium server, you can use this command : taskkill /F /PID PIDvalue"
else
    java -jar ./selenium-server-4.1.2.jar hub --port 4444 &
    sleep 3
    java -jar ./selenium-server-4.1.2.jar node --config ./config/chrome-node.toml &
    sleep 3
    java -jar ./selenium-server-4.1.2.jar node --config ./config/firefox-node.toml &
    sleep 3
fi

if [ $(curl http://localhost:4444/status | jq -r '.value.ready') != false ]
        then
        echo "selenium started : Done"
        fi
exit 0


