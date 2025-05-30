#!/bin/bash
# - SW - 01/12/2022 21:58 -
# Install flatpaks from a file containing list of ids, starting with source
# They are concatanated after flatpak install command

user=
if [ "$1" == "--user" ] || [ "$1" == "-u" ]; then
    user="--user"
    shift
fi
if [ -z "$1" ]; then
    echo "ERROR: Give me a file containing flatpaks to install"
    exit 1
fi
if [ ! -f "$1" ]; then
    echo "ERROR: Cannot find file '$1'"
    exit 1
fi
filelist="$1"
shift
if [ "$1" == "--user" ] || [ "$1" == "-u" ]; then
    user="--user"
    shift
fi

echo "Flatpaks from file '$filelist':"
echo "---"
cat "$filelist"
echo "---"
echo "HINT: Respond 'e' to edit the list of flatpaks before continuing"
read -r -p 'Install the above packages now via flatpak? (y/e/[N]): ' response
while [ $response == "e" ]; do
    echo "Opening in vi..."
    sleep 1s
    vi "$filelist"
    echo "Flatpaks from file '$filelist':"
    echo "---"
    cat "$filelist"
    echo "---"
    echo "HINT: Respond 'e' to edit the list of flatpaks before continuing"
    read -r -p 'Install the above packages now via flatpak? (y/e/[N]): ' response
done
case "$response" in
    [yY][eE][sS]|[yY])
        echo "Working..."
        # Install from file content
        flatpak install -y $user "$@" $(cat "$filelist") && exit 0
        ;;
    *)
        echo "Skipping"
        exit 1
        ;;
esac

