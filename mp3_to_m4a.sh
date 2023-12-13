#!/bin/bash

#sudo chmod +x mp3_to_m4a.sh 
# sudo ./mp3_to_m4a.sh  source_directory output_directory

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo "Error: ffmpeg is not installed. Please install ffmpeg first."
    exit 1
fi

# Check for the correct number of arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <source_directory> <output_directory>"
    exit 1
fi

# Get source and output directories from command-line arguments
source_directory="$1"
output_directory="$2"

# Check if the source directory exists
if [ ! -d "$source_directory" ]; then
    echo "Error: Source directory not found."
    exit 1
fi

# Check if the output directory exists, if not, create it
mkdir -p "$output_directory"

# Iterate over all MP3 files in the source directory
for mp3_file in "$source_directory"/*.mp3; do
    # Get the filename without extension
    filename=$(basename "$mp3_file" .mp3)

    # Construct the output M4A file path
    m4a_file="$output_directory/$filename.m4a"

    # Use ffmpeg to convert MP3 to M4A
    ffmpeg -i "$mp3_file" -acodec aac -strict -2 "$m4a_file"

    echo "Converted: $filename.mp3 to $filename.m4a"
done

echo "Conversion complete!"