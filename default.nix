with import <nixpkgs> {};
with builtins;
let
  version-regex = ".*NIXTO_VERSION=\"([0-9]\\.[0-9]\\.[0-9])\".*";
  version = elemAt (match version-regex (readFile ./bin/nixto)) 0;
in
stdenv.mkDerivation {
  name = "nixto-" + version;
  src  = ./bin;
  installPhase = ''
    mkdir -p $out/bin/
    cp ./nixto $out/bin/
  '';
}
