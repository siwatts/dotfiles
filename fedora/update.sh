#!/bin/bash
# Prompt user and upgrade system if requested, return 0 if done, return 1 if not

read -r -p 'DNF upgrade all packages and reboot now? (y/[N]): ' response
case "$response" in
    [yY][eE][sS]|[yY])
        echo "Using DNF offline-upgrade plugin can be more safe on a physical machine, but is not pre-installed on some systems like the KDE spin and can cause issues in some VMs"
        read -r -p 'Use more risky fallback live dnf upgrade in current login session? (recommended for VMs)? (y/[N]): ' response
        case "$response" in
            [yY][eE][sS]|[yY])
                echo "Working..."; sudo dnf upgrade -y && echo "Initiating REBOOT, 1 minute from $(date). Save and close all work." && sudo shutdown -r 1 && exit 0 || exit 1
                ;;
            *)
                echo "Working..."; sudo dnf offline-upgrade download -y && echo "Initiating REBOOT, 1 minute from $(date). Save and close all work." && sleep 1m && sudo dnf offline-upgrade reboot && exit 0 || exit 1
                ;;
        esac
        exit 0
        ;;
    *)
        exit 1
        ;;
esac

