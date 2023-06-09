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

        buildInputs = with pkgs; [
          cmake
          glfw
          libGL
          mesa
          xorg.libX11
        ];


      in

      {

        devShells.default = pkgs.mkShell {
          inherit buildInputs;
        };

        packages.default = pkgs.stdenv.mkDerivation rec {
          name = "glChAoS.P-master";

          src = ./.;

          dontConfigure = true;

          inherit buildInputs;

          buildPhase = ''
            cd src/
            sh build_glChAoSP.sh
          '';

          installPhase = ''
            mkdir -p $out
            cp ../glChAoSP_Linux $out/glChAoSP
          '';
        };

      });
}