#!/bin/bash

# Fix or re-encode MP3 files using ffmpeg and fzf
# Dependencies: ffmpeg, fzf

# Let user pick one or more MP3 files
files=$(find . -type f -iname "*.mp3" | fzf --multi --prompt="Select MP3 files to fix: ")

# Exit if no files selected
[ -z "$files" ] && echo "No files selected." && exit 0

# Create output directory
mkdir -p fixed

# Process each selected file
while IFS= read -r input; do
    filename=$(basename "$input")
    output="fixed/$filename"

    echo "🎧 Processing: $input → $output"

    ffmpeg -err_detect ignore_err -i "$input" -acodec libmp3lame -b:a 192k -y "$output" >/dev/null 2>&1

    if [ $? -eq 0 ]; then
        echo "✅ Done: $output"
    else
        echo "❌ Failed: $input"
    fi
done <<<"$files"

echo "✨ All selected files processed."
