#!/bin/bash
# - SW - 30/05/2025 19:36 -
# Install dnf packages from a file containing list of package names
# They are concatanated after dnf install command

if [ -z "$1" ]; then
    echo "ERROR: Give me a file containing dnf packages to install"
    exit 1
fi
if [ ! -f "$1" ]; then
    echo "ERROR: Cannot find file '$1'"
    exit 1
fi
filelist="$1"
shift

echo "DNF packages from file '$filelist':"
echo "---"
cat "$filelist"
echo "---"
echo "HINT: Respond 'e' to edit the list of packages before continuing"
read -r -p 'Install the above packages now via dnf? (y/e/[N]): ' response
while [ "$response" == "e" ]; do
    echo "Opening in vi..."
    sleep 1s
    vi "$filelist"
    echo "DNF packages from file '$filelist':"
    echo "---"
    cat "$filelist"
    echo "---"
    echo "HINT: Respond 'e' to edit the list of packages before continuing"
    read -r -p 'Install the above packages now via dnf? (y/e/[N]): ' response
done
case "$response" in
    [yY][eE][sS]|[yY])
        echo "Working..."
        # Install from file content
        sudo dnf install -y --skip-unavailable $(cat "$filelist") "$@" && exit 0
        ;;
    *)
        echo "Skipping"
        exit 1
        ;;
esac

