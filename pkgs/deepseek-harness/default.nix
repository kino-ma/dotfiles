{
  lib,
  stdenvNoCC,
  fetchurl,
  _7zz,
}:

stdenvNoCC.mkDerivation rec {
  pname = "deepseek-harness";
  version = "0.2.1-rc.2";

  src = fetchurl {
    url = "https://download.deepseek.com/desktop/dsh-latest-macos-arm64.dmg";
    hash = "sha256-0a32a236ffa2fa88e41ae353f8eb155ca9dc21fe27d3132432f6fe8f0697cc5a";
  };

  sourceRoot = ".";

  unpackCmd = ''
    python3 - <<'PY'
import lzma
from pathlib import Path
src = Path("$curSrc")
out = Path("dsh.dmg")
out.write_bytes(lzma.decompress(src.read_bytes()))
PY
    7zz x -snld -xr'!*:com.apple.*' dsh.dmg
  '';

  nativeBuildInputs = [ _7zz ];

  dontFixup = true;

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/Applications"

    while IFS= read -r -d "" app; do
      cp -R "$app" "$out/Applications/"
      /usr/bin/xattr -cr "$out/Applications/$(basename "$app")"
    done < <(find . -type d -name "*.app" -print0)

    found_app="$(find "$out/Applications" -maxdepth 1 -name "*.app" -print -quit)"
    if [ -z "$found_app" ]; then
      echo "No .app bundle found in the extracted DeepSeek download." >&2
      exit 1
    fi

    runHook postInstall
  '';

  meta = {
    description = "DeepSeek Harness desktop app";
    homepage = "https://deepseek.com";
    license = lib.licenses.unfree;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    platforms = [
      "x86_64-darwin"
      "aarch64-darwin"
    ];
  };
}
