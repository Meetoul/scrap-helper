#!/usr/bin/env bash

SKYSCRAPER_BIN=/home/user/projects/handheld/tools/skysource/Skyscraper

ROMS_DIR=/home/user/projects/handheld/collection/roms
MODULE=screenscraper
MODULE_PARAM=
FLAGS="unattend,relative,skipped"

if [ "$1" = "-s" ]
then
    MODULE_PARAM="-s $MODULE"
fi

for platform_dir in $ROMS_DIR/* ; do
    platform=$(basename $platform_dir)

    if [ "$platform" = "bios" ]
    then
        echo "Found bios directory, skipping..."
        continue
    fi

    if [ "$platform" = "psx" ]
    then
        echo "Found PSX platform, generating m3u files"
        ./mkm3u.sh $platform_dir
        echo "Generating m3u files done!"
    fi

    echo "Scrapping $platform..."
    $SKYSCRAPER_BIN $MODULE_PARAM -i $platform_dir -o $platform_dir -g $platform_dir -p $platform --flags $FLAGS
    echo "Scrapping $platform done!"
done
