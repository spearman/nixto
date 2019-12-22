# `nixto`

> NixTOol: NixOS command-line utility

This derivation installs an utility shell script called `nixto` into the path
that accepts various subcommands as shortcuts for common NixOS operations such
as searching for packages or querying system configuration.


## Installation

To install at the system level, add the following to the
`environment.systemPackages` list in `/etc/nixos/configuration.nix`:

```
  environment.systemPackages = with pkgs; [
    ...
    (import (fetchgit {
      url = git://github.com/spearman/nixto.git;
      rev = "<revision-hash>";
      sha256 = "<source-hash>";
    }));
  ];
```

where `rev` is the hash of the desired git commit and `sha256` is the source
hash which can be prefetched for a particular revision from the command-line
with the `nix-prefetch-git` tool:

```
$ nix-prefetch-git --url git://github.com/spearman/nixto.git --rev <revision-hash>
```

The `--rev <revision-hash>` argument is optional if you just want to get the
source hash of the latest revision.


## Usage

Search packages (`$ nix-env -qaP --description <query>`):

    $ nixto search <query>

Show the nixpkgs directory (`$ nix-instantiate --find-file nixpkgs`):

    $ nixto nixpkgs dir

Show references for the store object with the given name (looks for store paths
matching `/nix/store/<hash>-<name>`)::

    $ nixto store references <name>

Full system GC-- deletes all old generations of all user profiles, the root
profile, and the system profile (`$ sudo nix-collect-garbage -d`):

    $ nixto system gc

List system generations (`$ sudo nix-env -p /nix/var/nix/profiles/system
--list-generations`):

    $ nixto system generations

List system packages (`$ nix-store -q --references /var/run/current-system/sw |
cut -d'-' -f2-`):

    $ nixto system packages

Rebuild system configuration and switch (`$ sudo nixos-rebuild switch`):

    $ nixto system rebuild
