{
  stdenv,
  lib,
  pkgs,
  fetchFromBitbucket,
}:
stdenv.mkDerivation rec {
  pname = "denise";
  version = "2.4";

  src = fetchFromBitbucket {
    owner = "piciji";
    repo = "denise";
    rev = "v${version}";
    hash = "sha256-pwdNyhs1F4FF0ld07aSnvxzYg2mEDBubTNzD2P/YfGw=";
  };

  buildInputs = with pkgs; [
    cmake
    stdenv
  ];

  nativeBuildInputs = with pkgs; [
    freetype
    pkg-config
    libpulseaudio.dev
    gtk3
    libxkbcommon
    libsysprof-capture
    xorg.libXdmcp
    xorg.libX11
    xorg.libXfixes
    xorg.libXext
    xorg.xcbutil
    systemd.dev
  ];

  configurePhase = "
    cmake -B builds/release -S . -DCMAKE_INSTALL_PREFIX=/usr
    ";

  buildPhase = ''
    cmake --build builds/release -j$NIX_BUILD_CORES
  '';

  installPhase = ''
    export DESTDIR="$out"
    cmake --build builds/release --target install
  '';

  meta = with lib; {
    homepage = "https://github.com/AssetRipper/AssetRipper";
    description = "AssetRipper";
    platforms = platforms.linux;
  };
}
