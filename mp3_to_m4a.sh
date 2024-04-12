#!/bin/bash

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo "Error: ffmpeg is not installed. Please install ffmpeg and try again."
    exit 1
fi

# Convert MP3 to M4A
for file in *.mp3; do
    if [ -f "$file" ]; then
        filename="${file%.*}"
        ffmpeg -i "$file" -c:a aac -b:a 256k "${filename}.m4a"
        if [ $? -eq 0 ]; then
            echo "Converted: $file"
        else
            echo "Failed to convert: $file"
        fi
    fi
done

echo "Conversion complete."