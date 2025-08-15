#!/bin/bash
set -e

if [ -n "${DOWNLOAD}" ]; then
    ./downloader.sh "$URL" "$DESTINATION"
fi

if [ -n "${CLEANUP}" ]; then
    rm -rfv "$DESTINATION"
    exit 0
fi
