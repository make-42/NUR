{
  lib,
  stdenv,
  fetchFromGitHub,
  gradle2nix,
  system,
}: let
  currentBuilder = gradle2nix.builders.${system};
in
  currentBuilder.buildGradlePackage rec {
    pname = "sdrtrunk";
    version = "0.6.1";

    src = fetchFromGitHub {
      owner = "DSheirer";
      repo = "sdrtrunk";
      rev = "v${version}";
      hash = "sha256-5cklAqO7KyDdkQM0fCZTT8DHsZx/Tf0c8B9TiLMLrkA=";
    };

    lockFile = ./gradle.lock;

    # pin deps with nix run github:tadfisher/gradle2nix/v2 -- --out-dir ./gradle-env

    meta = {
      description = "A cross-platform java application for decoding, monitoring, recording and streaming trunked mobile and related radio protocols using Software Defined Radios (SDR).";
      homepage = "https://github.com/DSheirer/sdrtrunk";
      changelog = "https://github.com/DSheirer/sdrtrunk/blob/${src.rev}/CHANGELOG";
      license = lib.licenses.gpl3Only;
      maintainers = with lib.maintainers; [];
      mainProgram = "sdrtrunk";
      platforms = lib.platforms.all;
    };
  }
