{
  stdenv,
  fetchurl,
  lib,
  pkgs,
  fetchFromGitHub,
  buildGoModule,
}:
buildGoModule rec {
  pname = "hayai";
  version = "0.0.1";

  buildInputs = with pkgs; [
    alsa-lib
    gtk3
    glfw
    gcc
    go
    pkg-config
    xorg_sys_opengl.out
    xorg.libX11.dev
    xorg.libXrandr.dev
    xorg.libXcursor.dev
    xorg.libXinerama.dev
    xorg.libXi.dev
    xorg.libXxf86vm.dev
    libglvnd
    libxkbcommon
  ];

  nativeBuildInputs = with pkgs; [pkg-config makeWrapper];

  subPackages = ["."];

  src = fetchFromGitHub {
  owner = "make-42";
  repo = "hayai";
  rev = "3af1f651c07338405411b3794bc50decc9b8655d";
  hash = "sha256-+LE9FFO3uMIGaD06xqhsbx5/Am11i6bV74RSvLUI2No=";
  };

  vendorHash = null;

  meta = with lib; {
    description = "An EEW system for Linux using JMA data provided by the Wolfx Project.";
    homepage = "https://github.com/make-42/hayai";
    license = licenses.gpl3;
    maintainers = [];
    platforms = platforms.linux;
  };

  postInstall = with pkgs; ''
    wrapProgram "$out/bin/hayai" \
    --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [
      pkg-config
      alsa-lib
      gtk3
      glfw
      xorg_sys_opengl.out
      xorg.libX11.dev
      xorg.libXrandr.dev
      xorg.libXcursor.dev
      xorg.libXinerama.dev
      xorg.libXi.dev
      xorg.libXxf86vm.dev
      libglvnd
      libxkbcommon
    ]}
  '';
}
