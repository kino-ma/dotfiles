xdotool search --onlyvisible --name "$1" windowactivate --sync || "${2:-$1}"
