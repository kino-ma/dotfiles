xdotool search --onlyvisible --class "$1" windowactivate --sync || "${2:-$1}"
