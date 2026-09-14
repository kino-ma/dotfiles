{
  hooks = import ./hooks.nix;

  permissions = {
    allow = [
      "WebSearch"
      "WebFetch(domain:docs.anthropic.com)"
      "WebFetch(domain:github.com)"

      "Bash(git diff *)"
      "Bash(git fetch *)"
      "Bash(git log *)"
      "Bash(git ls-tree *)"
      "Bash(git show *)"
      "Bash(git status *)"

      "Bash(nix build *)"
      "Bash(nix eval *)"

      "Bash(javap *)"

      "Bash(command -v)"
      "Bash(nix *)"
      "Bash(python3 -m json.tool)"

      "Read(//tmp/**)"
    ];
    ask = [
      "Bash(git commit *)"
      "Bash(git push *)"
      "Bash(nix run *)"
    ];
    deny = [
      "Bash(brew *)"
      "Bash(pip install *)"
    ];
  };
}
