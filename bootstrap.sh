#!/bin/bash
#
# bootstrap.sh — one-liner entry point for a fresh Pi OS Lite flash.
#
#   curl -fsSL https://raw.githubusercontent.com/oforfamar/digital-frame/main/bootstrap.sh | bash
#
# Runs as the regular user (NOT root): installs git if missing, clones (or
# updates) the repo to a stable path, then runs the real installer via sudo.
# Do NOT pipe this into `sudo bash` — cloning as root breaks file ownership.

set -euo pipefail

REPO_URL="https://github.com/oforfamar/digital-frame.git"
CLONE_DIR="${CLONE_DIR:-$HOME/digital-frame}"

if [ "$(id -u)" -eq 0 ]; then
  echo "bootstrap: run me as your normal user, not root (I call sudo myself)." >&2
  exit 1
fi

# 1. Ensure git is present.
if ! command -v git >/dev/null 2>&1; then
  echo "bootstrap: installing git..."
  sudo apt-get update
  sudo apt-get install -y git
fi

# 2. Clone the repo, or update an existing checkout (idempotent).
if [ -d "$CLONE_DIR/.git" ]; then
  echo "bootstrap: updating existing checkout at $CLONE_DIR"
  git -C "$CLONE_DIR" pull --ff-only
else
  echo "bootstrap: cloning $REPO_URL -> $CLONE_DIR"
  git clone "$REPO_URL" "$CLONE_DIR"
fi

# 3. Run the real installer with sudo from the checkout.
echo "bootstrap: running installer (sudo)..."
sudo bash "$CLONE_DIR/install.sh"

echo "bootstrap: done. Reboot to start the slideshow:  sudo reboot"
