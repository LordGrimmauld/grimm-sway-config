{ lib
, pkgs
, stdenv
, fetchFromGitHub
}:

# { pkgs ? import <nixpkgs> {} }:

stdenv.mkDerivation rec {
  pname = "grimm-sway-themes";
  version = "0.1.0";

  doCheck = true;
#  dontUnpack = true;

  nativeBuildInputs = with pkgs; [
    hello
    waybar
    coreutils
    makeWrapper
  ];


  src = ./.;

  installPhase = ''
    # $out is an automatically generated filepath by nix,
    # but it's up to you to make it what you need. We'll create a directory at
    # that filepath, then copy our sources into it.
    mkdir -p $out/bin
    echo "outpath (install) is $out"
    echo "${grimm-sway-themes}"
    cp -rv ./src/* $out # */ comment to break the line comment thingy, super annoying
    cp ${pkgs.writeScript "test-res" ''echo "out path (runtime) $out"'' } $out/bin/test-res
    cp ${pkgs.writeScript "sway-with-config" "sway --unsupported-gpu" } $out/bin/sway-with-config
  '';

  postFixup = ''
          echo "outpath is $out"
          wrapProgram $out/bin/sway-with-config --set PATH ${lib.makeBinPath [ pkgs.swayfx pkgs.waybar pkgs.hello ]}
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
