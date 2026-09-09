#!/bin/bash

if [ -f stubborn.pid ]; then
  PID=$(cat stubborn.pid)

  if ps -p "$PID" > /dev/null 2>&1; then
    kill -9 "$PID"
  fi

  rm -f stubborn.pid
fi

echo "Stubborn process cleaned up."
