#!/bin/bash

echo "check availability to start selenium ..."
for i in 4444 4445 4446; do
    PID=$(netstat -ano | findStr "$i" | awk '{print $5}' | head -n 1)
    if [ -n "$PID" ]; then
        echo "the port: $i is used, tap this command in your powershell terminal to kill it"
        echo "taskkill /F /PID $PID"
    fi
done

if [ "$PID" ]; then
    echo "you will kill all this process before starting selelnium server"
    echo "restart start.sh script after finishing..."
else
    java -jar ./selenium-server-4.1.2.jar hub --port 4444 &
    sleep 3
    java -jar ./selenium-server-4.1.2.jar node --config ./config/chrome-node.toml &
    sleep 3
    java -jar ./selenium-server-4.1.2.jar node --config ./config/firefox-node.toml &
    sleep 3
    echo "selenium started : Done"
fi

exit 0


