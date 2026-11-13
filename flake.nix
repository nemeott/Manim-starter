# let
#   nixglhostSrc = fetchTarball {
#     url = "https://github.com/numtide/nix-gl-host/archive/refs/heads/main.tar.gz";
#   };
#   nixglhost = import nixglhostSrc { inherit pkgs; };
# in

{
  description = "Manim development flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    # nix-gl-host.url = "github:numtide/nix-gl-host";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          # buildInputs = with pkgs; [
          packages = with pkgs; [
            pkgs.stdenv.cc.cc.lib # provides libstdc++.so.6
            # nixglhost # bind to system driver (but ManimCE is CPU bound)

            python312
            uv

            pkg-config # manim dependencies
            ffmpeg
            cairo
            pango
            glib
            pixman
            fontconfig
            freetype
            harfbuzz
            texliveFull
            dejavu_fonts
          ];
        };

        shellHook = ''
          export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH
          export PKG_CONFIG_PATH=${pkgs.cairo.dev}/lib/pkgconfig:${pkgs.pango.dev}/lib/pkgconfig:${pkgs.fontconfig.dev}/lib/pkgconfig
          export FONTCONFIG_FILE=${pkgs.fontconfig.out}/etc/fonts/fonts.conf

          if [ ! -d .venv ]; then
            uv venv
          fi
        '';
      }
    );
}
