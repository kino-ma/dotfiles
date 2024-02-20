error() {
    echo >&2 "$@"
}

git_commit_with_prefix() {
    if [[ "$#" -lt 2 ]]; then
        error 'Not enough argument'
        exit
    fi

    GIT_PREFIX=$1
    GIT_COMMIT_MESSAGE=$2
    shift 2
    git commit -m "${GIT_PREFIX}: ${GIT_COMMIT_MESSAGE}" "$@"
}

git_commit_with_prefix $@
