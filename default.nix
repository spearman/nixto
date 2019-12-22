with {
  inherit (import <nixpkgs> {}) stdenv sudo;
  inherit (builtins) elemAt match readFile;
};
let
  version-regex = ".*NIXTO_VERSION=\"([0-9]\\.[0-9]\\.[0-9])\".*";
  version = elemAt (match version-regex (readFile ./nixto.sh)) 0;
in
stdenv.mkDerivation {
  name = "nixto-" + version;
  src = ./.;
  buildInputs = [ sudo ];
  installPhase = ''
    mkdir -p $out/bin
    cp ./nixto.sh $out/bin/nixto
  '';
}
