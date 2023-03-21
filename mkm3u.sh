#!/usr/bin/env bash

PSX_DIR="$1"

rm "$PSX_DIR/"*.m3u > /dev/null 2>&1

CUE_FILES=$(find $PSX_DIR -name "*.cue" -type f)

IFS=$'\n'
for cue_file in $CUE_FILES; do
        cue_basename=$(basename "$cue_file")
        title=$(echo "$cue_basename" | sed s'/.cue//g;s/ (Disc..)//g;s/ Disc..*$//g')

        cue_relative=$(realpath --relative-to="$PSX_DIR" "$cue_file")
        echo "./$cue_relative" >> "$PSX_DIR/$title".m3u
done
