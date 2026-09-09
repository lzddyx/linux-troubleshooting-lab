#!/bin/bash

if [ -z "$API_KEY" ]; then
  echo "ERROR: API_KEY environment variable is missing."
  exit 1
fi

echo "Application started successfully."
echo "API_KEY is configured."
