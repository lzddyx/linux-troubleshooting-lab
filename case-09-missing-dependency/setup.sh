#!/bin/bash

echo "Checking whether pendulum is installed..."

if python3 -m pip show pendulum >/dev/null 2>&1; then
  echo "pendulum is already installed."
  echo "To reproduce the missing dependency issue, run:"
  echo "python3 -m pip uninstall pendulum"
else
  echo "pendulum is not installed."
  echo "Run: python3 app.py"
fi
