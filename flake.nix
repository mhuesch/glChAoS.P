{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let

        pkgs = import nixpkgs {
          inherit system;
        };

      in

      {

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            cmake
            glfw
            libGL
            mesa
            xorg.libX11
          ];
        };

        packages.default = pkgs.stdenv.mkDerivation rec {
          name = "glChAoS.P-master";

          src = ./.;

          dontConfigure = true;

          buildInputs = with pkgs; [
            cmake
            glfw
            libGL
            mesa
            xorg.libX11
          ];

          buildPhase = ''
            cd src/
            sh build_glChAoSP.sh
            pwd
          '';

          installPhase = ''
            mkdir -p $out/bin
            cp ../glChAoSP_Linux $out/bin/glChAoSP
          '';

        };

      });
}
