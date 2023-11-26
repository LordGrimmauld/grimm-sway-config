{ lib
, stdenv
, fetchFromGitHub
}:

{ pkgs ? import <nixpkgs> {} }:

stdenv.mkDerivation rec {
  pname = "grimm-sway-themes";
  version = "0.1.0";

  doCheck = true;

  installPhase = ''
    # $out is an automatically generated filepath by nix,
    # but it's up to you to make it what you need. We'll create a directory at
    # that filepath, then copy our sources into it.
    echo "test test 123"
    mkdir $out
    cp -rv $src/* $out
  '';

  # passthru.tests.version =
  #  testVersion { package = grimm-sway-themes; };

  meta = with lib; {
    description = "My theme and config for sway + waybar";
    longDescription = ''
      this is a collection of relevant config files needed for sway and waybar
    '';
    homepage = "https://github.com/LordGrimmauld/grimm-sway-config";
    changelog = "https://github.com/LordGrimmauld/grimm-sway-config/commits/master";
    license = licenses.mit;
    maintainers = [ maintainers.grimmauld ];
    platforms = platforms.all;
  };
}
