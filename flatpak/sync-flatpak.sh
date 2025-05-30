#!/bin/bash

# cd to location of script, even if soft-linked
pushd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

./flatpak-install.sh core.txt
./flatpak-install.sh extras.txt

popd
exit 0
