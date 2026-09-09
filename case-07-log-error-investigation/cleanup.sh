#!/bin/bash

pkill -f "python3 -m http.server 8080" 2>/dev/null
rm -rf logs

echo "Log troubleshooting lab cleaned up."
