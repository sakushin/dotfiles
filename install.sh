#/bin/sh
cd `dirname $0`
srcdir=`pwd`

for f in .??*
do
  [ "$f" = ".git" ] && continue
  ln -snfv "$srcdir/$f" "$HOME/$f"
done

mkdir -pv "$HOME/.vim"
