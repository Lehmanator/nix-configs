{ pkgs, ... }:
#
# Moves a directory, then symlinks it to the old directory
#
# TODO: Do we need to add to PATH?
# TODO: Are bins in stdenv: realpath, basename, ln, mv?
# TODO: How to write shebangs in `pkgs.writeShellScript`
# TODO: Canonicalize paths (absolute paths, follow symlinks)
let
  mvlink = pkgs.writeShellScript "mvlink" ''
    src="$(realpath --logical $1)"
    dst="$(realpath --logical $2)"

    # TODO: Allow omitting new dirname in destination
    # When destination dir exists, new dir = $2/basename(srcDir)
    if [[ -d "$dst"]]; then
      dst="$dst/$(basename $src)"
    fi

    mv "$src" "$dst" && \
    ln -s "$dst" "$src"
  '';
in
{ home.packages = [mvlink]; }
