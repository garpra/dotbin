#!/usr/bin/env bash

set -euo pipefail

DESKTOP_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/applications/icons"

mkdir -p "$DESKTOP_DIR" "$ICON_DIR"

read -p "Name App : " APP_NAME
read -e -p "Path Appimage : " APP_PATH

if [[ ! -f "$APP_PATH" ]]; then
  echo "App Path not exist"
  exit 1
fi

SAFE_NAME=$(echo "$APP_NAME" |
  tr '[:upper:]' '[:lower:]' |
  sed 's/[^a-z0-9]/-/g; s/-\+/-/g; s/^-//; s/-$//')
ICON_PATH="$ICON_DIR/$SAFE_NAME.png"
FOUND_ICON=$(find /usr/share/icons ~/.local/share/icons -iname "$SAFE_NAME.svg" -print -quit)

if [[ -n "$FOUND_ICON" ]]; then
  ICON_PATH="$FOUND_ICON"
else
  echo "Could not get icon automatically. Enter PNG icon URL"
  read -p "Icon URL : " CUSTOM_URL
  if ! curl -fsSL -o "$ICON_PATH" "$CUSTOM_URL"; then
    echo "Failed to download custom icon"
    exit 1
  fi
fi

DESKTOP_FILE="$DESKTOP_DIR/$SAFE_NAME.desktop"

cat >"$DESKTOP_FILE" <<EOF
[Desktop Entry]
Version=1.0
Name=$APP_NAME
Comment=$APP_NAME
Exec=$(printf '%q' "$APP_PATH")
Terminal=false
Type=Application
Icon=$ICON_PATH
StartupNotify=true
EOF

chmod +x "$DESKTOP_FILE"

if [[ ! -x "$APP_PATH" ]]; then
  chmod +x "$APP_PATH"
fi

echo "Desktop entry created at: $DESKTOP_FILE"
