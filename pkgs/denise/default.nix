{
  stdenv,
  lib,
  pkgs,
  fetchFromBitbucket,
}:
stdenv.mkDerivation rec {
  pname = "denise";
  version = "1.1.11";

  src = fetchFromBitbucket {
    owner = "piciji";
    repo = "denise";
    rev = "d63c27b5c15f37ed930fbf2a0c87d3e4c66ec823";
    hash = "sha256-am08RVwZB8RcnQ8YIHujDScd4RzxkKJKFky2Li99OoE=";
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
