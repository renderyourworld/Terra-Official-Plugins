if [ -z "$SETUP_FILES" ]; then
    /terra/scripts/setup_files.sh "$DESTINATION" "$CUSTOM_PATH"
    exit 0
fi

if [ -z "$DOWNLOAD" ]; then
    /terra/scripts/download.sh "$URL" "$DESTINATION"
    exit 0
fi

sleep infinity
