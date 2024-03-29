#!/bin/sh

NIXTO_VERSION="0.0.3"

# version
if [ "$1" == "--version" ]; then
  echo "nixto $NIXTO_VERSION"

# nixto nixpkgs <subcmd>
elif [ "$1" == "nixpkgs" ]; then

  if [ "$2" == "dir" ]; then
    nix-instantiate --find-file nixpkgs

  else
    echo "Valid subcommands:"
    echo "  nixto nixpkgs dir"
    exit 1
  fi

# nixto search <query>
elif [ "$1" == "search" ]; then
  nix-env -qaP --description $2

# nixto store references <name>
elif [ "$1" == "store" ]; then
  if [ "$2" == "references" ]; then
    matches=$(ls -1 /nix/store | grep "\-$3")
    for match in $matches; do
      path="/nix/store/$match"
      echo "$path:"
      nix-store -q --references $path
    done
  else
    echo "Valid subcommands:"
    echo "  nixto store references <name>"
    exit 1
  fi

# nixto system <subcmd>
elif [ "$1" == "system" ]; then

  if [ "$2" == "gc" ]; then
    sudo nix-collect-garbage -d

  elif [ "$2" == "generations" ]; then
    sudo nix-env -p /nix/var/nix/profiles/system --list-generations

  elif [ "$2" == "packages" ]; then
    nix-store -q --references /var/run/current-system/sw | cut -d'-' -f2-

  elif [ "$2" == "rebuild" ]; then
    sudo nixos-rebuild switch

  else
    echo "Valid subcommands:"
    echo "  nixto system gc"
    echo "  nixto system generations"
    echo "  nixto system packages"
    echo "  nixto system rebuild"
    exit 1
  fi

# unrecognized
else
  echo "Available subcommands:"
  echo "  nixto --version"
  echo "  nixto nixpkgs dir"
  echo "  nixto search <query>"
  echo "  nixto store references <name>"
  echo "  nixto system <subcommand>"
  exit 1
fi

exit 0
