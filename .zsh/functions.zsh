git-commit-with-prefix() {
    GIT_PREFIX=$1
    GIT_COMMIT_MESSAGE=$2
    shift 2
    git commit -m "[$GIT_PREFIX] $GIT_COMMIT_MESSAGE" "$@"
}

alias xbrew='arch -x86_64 /usr/local/Homebrew/bin/brew'
