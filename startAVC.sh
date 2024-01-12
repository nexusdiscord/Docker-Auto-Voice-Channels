#!/usr/bin/env bash

# Functions
error=false
error() {
    printf "${RED}Error:${NC} ${1}\n"
    error=true
}

# Colors
RED='\033[0;31m'
NC='\033[0m' # No Color

# Optional environment variables
RDY_MESSAGE=${RDY_MESSAGE:-false}
DISABLE_LOOP=${DISABLE_LOOP:-false}
HEARTBEAT_TIMEOUT=${HEARTBEAT_TIMEOUT:-60}
AWS=${AWS:-false}

# Convert to lowercase
RDY_MESSAGE=$(echo "${RDY_MESSAGE}" | tr '[:upper:]' '[:lower:]')
DISABLE_LOOP=$(echo "${DISABLE_LOOP}" | tr '[:upper:]' '[:lower:]')
AWS=$(echo "${AWS}" | tr '[:upper:]' '[:lower:]')

# Validate environment variables
if [ -z "${ADMIN_ID}" -o -z "${CLIENT_ID}" -o -z "${TZ}" -o -z "${TOKEN}" ]; then
    error 'Please ensure the environment variables ADMIN_ID, CLIENT_ID, TZ, TOKEN are set!'
fi

if [[ ! ${ADMIN_ID} =~ ^[0-9]+$ ]]; then
    error 'ADMIN_ID must be a number!'
fi

if [[ ! ${CLIENT_ID} =~ ^[0-9]+$ ]]; then
    error 'CLIENT_ID must be a number!'
fi

if [ "${RDY_MESSAGE}" != "true" ] && [ "${RDY_MESSAGE}" != "false" ]; then
    error 'RDY_MESSAGE must be true or false!'
fi

if [ "${DISABLE_LOOP}" != "true" ] && [ "${DISABLE_LOOP}" != "false" ]; then
    error 'DISABLE_LOOP must be true or false!'
fi

if [[ ! ${HEARTBEAT_TIMEOUT} =~ ^[0-9]+$ ]]; then
    error 'HEARTBEAT_TIMEOUT must be a number!'
fi

if [ "${AWS}" != "true" ] && [ "${AWS}" != "false" ]; then
    error 'AWS must be true or false!'
fi

if [ ! -d /AutoVoiceChannels ]; then
    error "Folder /AutoVoiceChannels doesn't exists!"
fi

# Exit on errors
if [ "${error}" == "true" ]; then
    exit 1
fi

# Change folder
cd /AutoVoiceChannels

# Write configuration
cat > config.json << CONFIG_JSON
{
  "admin_id": ${ADMIN_ID},
  "client_id": ${CLIENT_ID},
  "log_timezone": "${TZ}",
  "token": "${TOKEN}",
  "disable_ready_message": ${RDY_MESSAGE},
  "disable_creation_loop": ${DISABLE_LOOP},
  "heartbeat_timeout": ${HEARTBEAT_TIMEOUT}
}
CONFIG_JSON

# Run server
if [ "${AWS}" = "true" ]; then
    python ./heartbeat.py & python ./auto-voice-channels.py
else
    python ./auto-voice-channels.py
fi
