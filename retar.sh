#!/bin/sh

if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
  echo "Usage:  retar.sh [<new-version>]"
  echo ""
  echo "Providing a version writes the version string to ./version.nix and"
  echo "renames the ./nixto-<version>/ directory. If no version is provided,"
  echo "the contents of version.nix will be used."
  exit

elif [ "$1" == "" ]; then
  version=$(echo $(cat version.nix) | tr -d '"')

else
  version="$1"
  oldversion=$(echo $(cat version.nix) | tr -d '"')
  set -x
  mv nixto-$oldversion nixto-$version
  rm -f nixto-$oldversion.tar.gz
  echo "\"$version\"" > version.nix
  set +x
fi

set -x
tar -zcf nixto-$version.tar.gz nixto-$version
git add nixto-$version.tar.gz nixto-$version
