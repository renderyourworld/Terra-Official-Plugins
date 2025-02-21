if [ -n "${SETUP_FILES}" ]; then
    /terra/scripts/setup_files.sh "$DESTINATION" "$CUSTOM_PATH"
fi

if [ -n "${DOWNLOAD}" ]; then
    /terra/scripts/downloader.sh "$URL" "$DESTINATION"
fi
