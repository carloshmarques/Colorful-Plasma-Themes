#!/bin/bash

echo "[SYSTEM] Checking for theme updates..."
cd "$(dirname "$0")"

# Pull latest changes from upstream
git pull upstream main

echo "[SYSTEM] Theme repository updated successfully."
