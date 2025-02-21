if [ -z "$SETUP_FILES" ]; then
    /terra/scripts/setup_files.sh "$DESTINATION" "$CUSTOM_PATH"
fi

if [ -z "$DOWNLOAD" ]; then
    /terra/scripts/download.sh "$URL" "$DESTINATION"
fi

sleep infinity
