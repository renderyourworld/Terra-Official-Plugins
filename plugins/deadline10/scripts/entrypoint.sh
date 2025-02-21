#!/bin/bash
set -e

if [ -n "${SETUP_FILES}" ]; then
    ./setup_files.sh "$DESTINATION" "$CUSTOM_PATH"
fi

if [ -n "${DOWNLOAD}" ]; then
    ./downloader.sh "$URL" "$DESTINATION"
fi

if [ -n "${REPO_INSTALLER}" ]; then
    ./repository_installer.sh "$DESTINATION" "$CUSTOM_PATH"
fi

if [ -n "${CLIENT_INSTALLER}" ]; then
    ./client_installer.sh "$DESTINATION"
fi

if [ -n "${SETUP_DIRECTORIES}" ]; then
    ./setup_directories.sh "$DESTINATION"
fi

if [ -n "${CLEANUP}" ]; then
    ./cleanup.sh
fi
