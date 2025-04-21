#! /bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEMES_DIR="${HOME}/.config/Vencord/themes"
THEME_FILES=("hide.css" "spoon.css")

# Check if Vencord themes directory exists
if [ ! -d "$THEMES_DIR" ]; then
    echo "Error: Vencord themes directory not found at $THEMES_DIR"
    exit 1
fi

# Check if source theme files exist
for file in "${THEME_FILES[@]}"; do
    if [ ! -f "$SCRIPT_DIR/$file" ]; then
        echo "Error: Source theme file '$file' not found in $SCRIPT_DIR"
        exit 1
    fi
done

# Create symbolic links
for file in "${THEME_FILES[@]}"; do
    if ! ln -sf "$SCRIPT_DIR/$file" "$THEMES_DIR/$file" 2> /tmp/discordTheme_error; then
        echo "Error: Failed to create symbolic link for $file"
        echo "Error details: $(cat /tmp/discordTheme_error)"
        rm -f /tmp/discordTheme_error
        exit 1
    fi
done

# Clean up and show success message
rm -f /tmp/discordTheme_error
echo "Discord Theme installed successfully!"
