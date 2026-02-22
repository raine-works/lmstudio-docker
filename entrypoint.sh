#!/bin/bash

# Ensure environment variables are set
PORT="${PORT:-1234}"

# 1. Start SSH
service ssh start

# 3. Start the LM Studio Daemon
echo "Starting LM Studio Daemon..."
lms daemon up

# 4. Start the Server (It will automatically detect the LM_API_TOKEN)
echo "Starting LM Studio Server..."
lms server start --port ${PORT} --cors --bind 0.0.0.0 &

# 5. Keep alive
tail -f /dev/null
