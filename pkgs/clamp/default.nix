{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  ...
}:

stdenvNoCC.mkDerivation rec {
  pname = "clamp";
  version = "v1.4.1";

  src = fetchFromGitHub {
    owner = "wsagency";
    repo = "claude-move-project";
    rev = version;
    hash = "sha256-mRM49rf7ilg7ajEfiT1W6wxY9TvH6XEvkOmvCT/gb5U=";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/bin"
    cp clamp "$out/bin/"
    runHook postInstall
  '';

  meta = {
    description = "Move Claude Code projects while preserving session history";
    homepage = "" "https://github.com/wsagency/claude-move-project" "";
    license = lib.licenses.mit;
  };
}
