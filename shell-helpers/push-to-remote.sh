set -euo pipefail

echo ''
branch="$(git rev-parse --abbrev-ref HEAD)"
echo "Currently on branch '$branch'"
echo ''
git log --max-count 10 --graph --date=short --decorate=short --pretty=format:'%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s'
echo ''
echo '----------'
echo ''

printf "Please confirm current state... [Enter]: "
read
echo ''

printf "Push '$branch' to remote? [y/N]: "
read answer
echo ''

case "$answer" in
    [yY])
        git push --set-upstream origin "$branch"
        ;;

    *)
        echo "Canceled."
        exit 1
esac

echo ''
echo 'Done.'
