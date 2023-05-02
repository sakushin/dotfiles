#/bin/sh
cd `dirname $0`
srcdir=`pwd`

find . -maxdepth 1 -type f -name '.*' -printf '%f\n' | while read f; do
  ln -sv "$srcdir/$f" "$HOME/"
done

find .config/. -maxdepth 1 -mindepth 1 -printf '%f\n' | while read f; do
  ln -sv "$srcdir/.config/$f" "$HOME/.config/"
done

mkdir -pv "$HOME/.vim"
