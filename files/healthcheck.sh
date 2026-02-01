#!/bin/bash
# OpenClaw healthcheck script

# Check if openclaw gateway is responding
if curl -sf http://localhost:18789/health > /dev/null 2>&1; then
    echo "OK: OpenClaw gateway is responding"
    exit 0
else
    echo "CRITICAL: OpenClaw gateway is not responding"
    exit 1
fi
