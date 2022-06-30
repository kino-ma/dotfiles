# If this session itself is a SSH session
if [[ ( -n "$SSH_CONNECTION" ) && ( -n "$SSH_AUTH_SOCK" ) ]]
then
    echo "SSH_AUTH_SOCK: $SSH_AUTH_SOCK"
    # SSH_AUTH_SOCK is already set
else
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
