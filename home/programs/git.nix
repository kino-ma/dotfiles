{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.git = {
    enable = true;

    signing = {
      key = lib.mkDefault "F0D7A2F02CAE648A";
      signByDefault = true;
    };

    settings = {
      pull.ff = "only";
      init.defaultBranch = "main";

      user = lib.mkDefault {
        Name = "kino-ma";
        Email = "ma@kino.ma";
      };

      alias = {
        c = "commit -m";
        cn = "commit --no-gpg-sign -m";
        ca = "commit --amend --no-edit";
        s = "status";
        d = "diff";
        ds = "diff --staged";
        rs = "restore --staged";
        sc = "switch --create";
        p = "pull";
        pp = "push";
        ppp = "!bash ${../../shell-helpers/push-to-remote.sh}";

        c-feat = "!sh ${../../shell-helpers/commit-with-prefix.sh} feat";
        c-fix = "!sh ${../../shell-helpers/commit-with-prefix.sh} fix";
        c-refactor = "!sh ${../../shell-helpers/commit-with-prefix.sh} refactor";
        c-test = "!sh ${../../shell-helpers/commit-with-prefix.sh} test";
        c-perf = "!sh ${../../shell-helpers/commit-with-prefix.sh} perf";
        c-style = "!sh ${../../shell-helpers/commit-with-prefix.sh} style";
        c-docs = "!sh ${../../shell-helpers/commit-with-prefix.sh} docs";
        c-build = "!sh ${../../shell-helpers/commit-with-prefix.sh} build";
        c-ci = "!sh ${../../shell-helpers/commit-with-prefix.sh} ci";

        force-clean = "clean -fdX";
        gr = "log --graph --date=short --decorate=short --pretty=format:'%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s'";
        m-init = "submodule update --init --recursive";
      };
    };

    ignores = [
      "*.*~"
      "*.swp"
      ".vscode"
      ".DS_Store"
      ".direnv"
      ".envrc"
      ".claude/settings.local.json"
    ];
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      line-numbers = true;
      side-by-side = true;
      dark = true;
    };
  };
}
