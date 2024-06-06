{
  enable = true;
  userName = "kino-ma";
  userEmail = "ma@kino.ma";
  signing =
    {
      key = "F0D7A2F02CAE648A";
      signByDefault = true;
    };

  delta = {
    enable = true;
    options = {
      line-numbers = true;
      side-by-side = true;
      dark = true;
    };
  };

  extraConfig = {
    pull.ff = "only";
    init.defaultBranch = "main";
  };

  aliases =
    {
      c = "commit -m";
      cn = "commit --no-gpg-sign -m";
      s = "status";
      d = "diff";
      ds = "diff --staged";
      rs = "restore --staged";
      sc = "switch --create";

      c-feat      = ''!sh ${../../shell-helpers/commit-with-prefix.sh} feat'';
      c-fix       = ''!sh ${../../shell-helpers/commit-with-prefix.sh} fix'';
      c-refactor  = ''!sh ${../../shell-helpers/commit-with-prefix.sh} refactor'';
      c-test      = ''!sh ${../../shell-helpers/commit-with-prefix.sh} test'';
      c-perf      = ''!sh ${../../shell-helpers/commit-with-prefix.sh} perf'';
      c-style     = ''!sh ${../../shell-helpers/commit-with-prefix.sh} style'';
      c-docs      = ''!sh ${../../shell-helpers/commit-with-prefix.sh} docs'';
      c-build     = ''!sh ${../../shell-helpers/commit-with-prefix.sh} build'';
      c-ci        = ''!sh ${../../shell-helpers/commit-with-prefix.sh} ci'';

      force-clean = "clean -fdX";
      gr = "log --graph --date=short --decorate=short --pretty=format:'%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s'";
      m-init = "submodule update --init --recursive";
    };

  ignores =
    [
      "*.*~"
      "*.swp"
      ".vscode"
      ".DS_Store"
      ".direnv"
    ];
}
