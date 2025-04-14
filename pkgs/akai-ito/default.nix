{
  stdenv,
  fetchurl,
  lib,
  pkgs,
  fetchFromGitHub,
  buildGoModule,
  makeDesktopItem,
}:
buildGoModule
rec {
  pname = "akai-ito";
  version = "0.0.1";

  buildInputs = with pkgs; [
    gcc
    go
    glfw
    pkg-config
    xorg.libX11.dev
    xorg.libXrandr.dev
    xorg.libXcursor.dev
    xorg.libXinerama.dev
    xorg.libXi.dev
    xorg.libXxf86vm.dev
    libglvnd
  ];

  nativeBuildInputs = with pkgs; [pkg-config makeWrapper];

  subPackages = ["."];

  src = fetchFromGitHub {
    owner = "make-42";
    repo = "akai-ito";
    rev = "72c45c8ed975230e5ef9c51e709f3d2c00003e18";
    hash = "sha256-e8ABqtXpDm3FxNH32tsId0m+tH26wY7rOsDBrvvq2nM=";
  };

  vendorHash = null;

  meta = with lib; {
    description = "akai-ito.";
    homepage = "https://github.com/make-42/akai-ito";
    license = licenses.gpl3;
    maintainers = [];
    platforms = platforms.linux;
  };

  postInstall = ''
    wrapProgram "$out/bin/akai-ito" \
    --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [
      pkgs.glfw
      pkgs.pkg-config
      pkgs.xorg.libX11.dev
      pkgs.xorg.libXrandr.dev
      pkgs.xorg.libXcursor.dev
      pkgs.xorg.libXinerama.dev
      pkgs.xorg.libXi.dev
      pkgs.xorg.libXxf86vm.dev
      pkgs.libxkbcommon
      pkgs.libglvnd
    ]}
    #install -Dm644 $src/icons/assets/icon.svg $out/share/icons/hicolor/scalable/apps/akai-ito.svg
    #install -Dm644 $src/xyosc.desktop $out/share/applications/akai-ito.desktop
  '';
}
