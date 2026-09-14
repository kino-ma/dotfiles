## 作業ルール

作業にあたり以下のルールに従ってください。

- MUST NOT: グローバル環境に対する設定変更は禁止
  - 例えば `~/.zshrc`、 `~/.config/**` など
- SHOULD: 一時ディレクトリを使用する場合は作業ディレクトリ配下に作成する
  - `./.claude/tmp` を作成し、 `./.claude/tmp/.gitignore` で無視設定を行う
- SHOULD: 使い捨てスクリプトは一時ディレクトリ配下に一度書き出す
  - シェルのリダイレクトやパイプで渡す (`python3 -` や 3 コマンド以上の `bash -c` など) は避け、ファイルに書き出す

## 追加ソフトウェア使用ルール

作業環境に見つからないコマンド、ツールが必要な場合は以下のルールに従ってください。

- MAY: グローバル環境に見つからない追加ソフトウェアを使用したい場合は、 Nix, Docker を使用してください
  - nix-shell、 nix run、 docker run --rm など
- MAY: ローカルのみに作用するコマンドは使用可能です
  - npm install など
  - curl や wget での直接ダウンロードも可能ですが、一時ディレクトリにダウンロードするようにしてください
- MUST NOT: グローバル環境へのソフトウェアインストールは禁止
  - グローバルに作用するパッケージマネージャ（brew, npm install の -g つき等）を使ったパッケージのインストールは禁止
  - Nix を使う場合、 nix-shell、 nix run 等は可能ですが、 nix-env や nix profile は禁止

## Bash 使用ルール

Bash ツールを使用する際は以下のルールに従ってください。

- MUST NOT: `cd` を複合コマンドに含めない
  - NG: `cd X && echo ... > file` のよように cd 
- MUST: ファイル読み書き・リダイレクト先は必ず絶対パスで指定する
  - NG: `cd X && grep hoge > tmp/out.txt`
  - OK: `grep hoge /path/to/X > /path/to/cwd/tmp/out.txt`
  - 作業ディレクトリ相対で書きたい場合も cwd 起点の相対パスを使う
