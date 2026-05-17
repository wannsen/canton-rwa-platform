#!/bin/bash
set -e
echo "Installing Daml SDK dependencies..."
daml version 2>/dev/null || echo "Please install Daml SDK 3.x from https://docs.daml.com/"
if [ ! -d "../daml-finance" ]; then
  echo "Cloning daml-finance library..."
  git clone https://github.com/digital-asset/daml-finance.git ../daml-finance
fi
echo "Dependencies ready. Run 'daml build' to compile."
