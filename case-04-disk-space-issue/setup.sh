#!/bin/bash

mkdir -p cache data logs

echo "cache data" > cache/cache.tmp
echo "normal application data" > data/app.data

dd if=/dev/zero of=logs/app.log bs=1M count=50

echo "Disk space troubleshooting lab created."
