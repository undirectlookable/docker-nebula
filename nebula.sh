#!/bin/sh

# Set ARG
PLATFORM=$1
TAG=$2
if [ -z "$PLATFORM" ]; then
    ARCH="amd64"
else
    case "$PLATFORM" in
        linux/386)
            ARCH="386"
            ;;
        linux/amd64)
            ARCH="amd64"
            ;;
        linux/arm/v6)
            ARCH="arm-6"
            ;;
        linux/arm/v7)
            ARCH="arm-7"
            ;;
        linux/arm64|linux/arm64/v8)
            ARCH="arm64"
            ;;
        *)
            ARCH=""
            ;;
    esac
fi
[ -z "${ARCH}" ] && echo "Error: Not supported OS Architecture" && exit 1
[ -z "${TAG}" ] && echo "Error: Missing tag" && exit 1

# Download files
NEBULA_FILE="nebula-linux-${ARCH}.tar.gz"

echo "Downloading binary file: ${NEBULA_FILE}"

wget -O ${PWD}/nebula.tar.gz https://github.com/slackhq/nebula/releases/download/${TAG}/${NEBULA_FILE} > /dev/null 2>&1

if [ $? -ne 0 ]; then
    echo "Error: Failed to download binary file: ${NEBULA_FILE}" && exit 1
fi
echo "Download binary file: ${NEBULA_FILE} completed"

# Prepare
echo "Prepare to use"
mkdir -p /etc/nebula
tar -xzof nebula.tar.gz --strip-components=0
chmod +x nebula nebula-cert
mv nebula nebula-cert /usr/local/bin/

# Clean
rm -rf ${PWD}/*
echo "Done"
