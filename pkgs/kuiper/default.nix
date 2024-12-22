{
  stdenv,
  fetchurl,
  lib,
  pkgs,
  fetchFromGitHub,
  buildGoModule,
}:
buildGoModule rec {
  pname = "kuiper";
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
    libxkbcommon
  ];

  nativeBuildInputs = with pkgs; [pkg-config makeWrapper];

  subPackages = ["."];

  src = fetchFromGitHub {
    owner = "make-42";
    repo = "kuiper";
    rev = "604b74879a5f811b13607d5db020563f62fef51f";
    hash = "sha256-RQqQQk0V0TZ3WfZAqcJiFiLRSl9IMSvJ3IXzN3adQ+A=";
  };

  vendorHash = null;

  meta = with lib; {
    description = "Controlling your mouse with your keyboard";
    homepage = "https://github.com/make-42/kuiper";
    license = licenses.gpl3;
    maintainers = [];
    platforms = platforms.linux;
  };

  postInstall = ''
    wrapProgram "$out/bin/kuiper" \
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
  '';
}