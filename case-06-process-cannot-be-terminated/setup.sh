#!/bin/bash

trap '' TERM

echo "Starting process that ignores SIGTERM..."
echo $$ > stubborn.pid

while true
do
  sleep 1
done
