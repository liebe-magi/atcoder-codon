#!/bin/bash

# Define paths
TEMPLATE_DIR="template"
USER_DATA_DIR="user_data"
CONFIG_DIR="$USER_DATA_DIR/config"
CONTENTS_DIR="$USER_DATA_DIR/contents"

# Check if user_data directory exists
if [ ! -d "$USER_DATA_DIR" ]; then
    echo "Initializing user_data directory..."
    mkdir -p "$USER_DATA_DIR"
else
    echo "user_data directory already exists."
fi

# Initialize config
if [ ! -d "$CONFIG_DIR" ]; then
    echo "Copying config templates..."
    cp -r "$TEMPLATE_DIR/config" "$CONFIG_DIR"
else
    echo "Config directory already exists. Skipping copy."
fi

# Initialize contents
if [ ! -d "$CONTENTS_DIR" ]; then
    echo "Creating contents directory..."
    mkdir -p "$CONTENTS_DIR"
    # Create a placehold file or README in contents if needed
    echo "# User Contents" > "$CONTENTS_DIR/README.md"
else
    echo "Contents directory already exists."
fi

echo "Setup complete! Your data is in '$USER_DATA_DIR'."
