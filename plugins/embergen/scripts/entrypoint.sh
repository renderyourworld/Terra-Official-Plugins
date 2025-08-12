#!/bin/bash
set -e

if [ -n "$CLEANUP" ]; then
  rm -rvf "$DESTINATION/embergen-$VERSION-linux"
  exit 0
fi

if [ -n "${INSTALL}" ]; then
    ./installer.sh "$VERSION" "$DESTINATION"
fi
