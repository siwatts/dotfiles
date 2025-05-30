#!/bin/bash
# - SW - 30/05/2025 21:14 -
# Install RPM Fusion repositories

VER=42
ACTUAL=$(rpm -E %fedora)
if [ ! $ACTUAL -eq $VER ]; then
    echo "Error: RPM Fusion installation commands stale"
    echo "       Retrieved for Fedora $VER, require $ACTUAL"
    echo "Skipping"
    exit 1
fi

echo "Enabling RPM Fusion repositories from https://rpmfusion.org/Configuration..."
# https://rpmfusion.org/Configuration
# Retrieved 30/05/2025
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1 -y
sudo dnf update @core -y
sudo dnf install rpmfusion-\*-appstream-data -y

exit 0

