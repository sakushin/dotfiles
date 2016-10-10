#/bin/sh
cd `dirname $0`
srcdir=`pwd`

for f in .??*
do
  [ "$f" = ".git" ] && continue
  ln -sv "$srcdir/$f" "$HOME/$f"
done

mkdir -pv "$HOME/.vim"
