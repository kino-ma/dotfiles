if [[ ( -n "$SSH_CONNECTION" ) && ( -n "$SSH_AUTH_SOCK" ) ]]
then
    # If this session itself is a SSH session
    # So SSH_AUTH_SOCK is already set by SSH Agent. Nothing to do here
else
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
