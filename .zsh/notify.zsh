# Notify when a foreground command takes longer than this many seconds.
ZSH_NOTIFY_THRESHOLD=10

autoload -Uz add-zsh-hook

_notify_timer_preexec() {
    _notify_timer_cmd="$1"
    _notify_timer_start=$SECONDS
}

_notify_timer_precmd() {
    local exit_status=$?
    [[ -z "$_notify_timer_start" ]] && return
    local elapsed=$(( SECONDS - _notify_timer_start ))
    [[ "$exit_status" == '0' ]] && local soundName="Glass" || local soundName="Alert"
    unset _notify_timer_start
    if (( elapsed >= ZSH_NOTIFY_THRESHOLD )); then
        # Pass the message as an argument so quotes in the command can't break
        # out of the AppleScript string.
        osascript \
            -e 'on run argv' \
            -e 'display notification (item 1 of argv) with title (item 2 of argv) sound name (item 3 of argv)' \
            -e 'end run' \
            -- \
            "${_notify_timer_cmd} (${elapsed}s)" \
            "Command fininshed (${status})" \
            "${soundName}" \
            >/dev/null 2>&1
    fi
}

add-zsh-hook preexec _notify_timer_preexec
add-zsh-hook precmd _notify_timer_precmd
