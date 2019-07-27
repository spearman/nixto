with import <nixpkgs> {};
let
  version = import ./version.nix;
in
stdenv.mkDerivation rec {
  name = "nixto-" + version;
  src  = ./nixto- + version + ".tar.gz";
  buildInputs = [sudo];
  installPhase = ''
    mkdir -p $out/bin/
    cp ./nixto $out/bin/
  '';
}
