{ fetchzip, lib, stdenvNoCC }:

stdenvNoCC.mkDerivation rec {
  pname = "scroll-reverser";
  version = "1.9";

  src = fetchzip {
    url = "https://github.com/pilotmoon/Scroll-Reverser/releases/download/v${version}/ScrollReverser-${version}.zip";
    hash = "sha256-1MrOaJbSE1pYb+nBIBh9WXTUphEZ/YcyBVJZuwc/3lQ=";
  };

  dontFixup = true;

  installPhase = ''
    runHook preInstall
    APP_DIR="$out/Applications/Scroll Reverser.app"
    mkdir -p "$APP_DIR"
    cp -r . "$APP_DIR"
    runHook postInstall
  '';

  meta = with lib; {
    description = "Per-device scrolling prefs on macOS.";
    homepage = "https://pilotmoon.com/scrollreverser/";
    license = licenses.asl20;
    platforms = [ "x86_64-darwin" "aarch64-darwin" ];
  };
}
