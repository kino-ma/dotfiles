git_commit_with_prefix() {
    GIT_PREFIX=$1
    GIT_COMMIT_MESSAGE=$2
    shift 2
    git commit -m "${GIT_PREFIX}: ${GIT_COMMIT_MESSAGE}" "$@"
}
