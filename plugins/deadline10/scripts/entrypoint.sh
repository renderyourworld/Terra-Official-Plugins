# shellcheck disable=SC2164
cd /terra/scripts

if [ -n "${SETUP_FILES}" ]; then
    ./setup_files.sh "$DESTINATION" "$CUSTOM_PATH"
fi

if [ -n "${DOWNLOAD}" ]; then
    ./downloader.sh "$URL" "$DESTINATION"
fi
