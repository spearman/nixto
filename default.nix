with {
  inherit (import <nixpkgs> {}) lib makeWrapper runCommand sudo;
  inherit (builtins) elemAt match readFile;
};
let
  version-regex = ".*NIXTO_VERSION=\"([0-9]\\.[0-9]\\.[0-9])\".*";
  version = elemAt (match version-regex (readFile ./nixto.sh)) 0;
  name = "nixto-" + version;
in
runCommand name { buildInputs = [ makeWrapper sudo ]; }
''
  makeWrapper ${./nixto.sh} $out/bin/nixto \
    --prefix PATH : ${lib.makeBinPath [ sudo ]}
''
