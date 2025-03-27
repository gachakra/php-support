#!/usr/bin/env bash

set -e  # Exit immediately on error

echo 'Copying .env.example files to .env files (non-overwriting)'

# Find all `.env.example` files, excluding vendor, and copy them if not already existing.
find . -type f -name '.env.example' ! -path "./vendor/*" | while read -r file; do
    dest="${file%.env.example}.env"
    if [[ ! -f "$dest" ]]; then
        cp "$file" "$dest"
        echo "Created $dest"
    else
        echo "Skipped $dest (already exists)"
    fi
done

# Check if Docker is running before proceeding
if ! docker info >/dev/null 2>&1; then
    echo "Docker is not running! Please start Docker and rerun this script."
    exit 1
fi

# Build and start Docker containers
echo 'Building and starting Docker containers...'
docker compose build --parallel && docker compose up -d --force-recreate