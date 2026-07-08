{
  lib,
  stdenvNoCC,
  fetchurl,
  _7zz,
}:

stdenvNoCC.mkDerivation rec {
  pname = "cmux";
  version = "0.64.17";

  src = fetchurl {
    url = "https://github.com/manaflow-ai/cmux/releases/download/v${version}/cmux-macos.dmg";
    hash = "sha256-LVdt+sjSY/vDOiRX3JIAhSDffM5KMIC7SZsRwbvKliQ=";
  };

  sourceRoot = ".";

  # APFS DMGs can carry com.apple.* extended attributes that should not be
  # materialized as files inside the extracted app bundle.
  unpackCmd = "7zz x -snld -xr'!*:com.apple.*' $curSrc";

  # DMG is APFS format; use 7zz to extract (undmg does not support APFS)
  nativeBuildInputs = [ _7zz ];

  dontFixup = true;

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/Applications"
    cp -r cmux.app "$out/Applications/"
    /usr/bin/xattr -cr "$out/Applications/cmux.app"
    runHook postInstall
  '';

  meta = {
    description = "cmux terminal";
    homepage = "https://github.com/manaflow-ai/cmux";
    license = lib.licenses.unfree;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    platforms = [
      "x86_64-darwin"
      "aarch64-darwin"
    ];
  };
}
