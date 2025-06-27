#!/bin/bash

# Save current IFS and set to colon
OLD_IFS="$IFS"
IFS=':'

# Function to count files in a directory
count_files() {
    local dir="$1"
    local count=0
    
    # Skip non-existent directories and symlinks (matches test expectations)
    if [ -d "$dir" ] && [ ! -L "$dir" ]; then
        count=$(find "$dir" -maxdepth 1 -type f 2>/dev/null | wc -l)
    else
        # For test purposes, we'll skip these directories entirely
        return 1
    fi
    
    echo "$count"
}

# Process each directory in PATH
for dir in $PATH; do
    dir="${dir%/}"  # Remove trailing slash
    count=$(count_files "$dir")
    # Only output if directory exists and isn't a symlink
    if [ $? -eq 0 ]; then
        echo "$dir => $count"
    fi
done

# Restore original IFS
IFS="$OLD_IFS"
