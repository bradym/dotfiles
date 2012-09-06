#!/bin/bash
# =========================================================
# Setup dotfiles from cloned git repo
# =========================================================

# Where does this script live?
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Where should symlinks be created?
TARGET="$HOME/testing"

# --------------------------------------------------------
# Setup bash
# --------------------------------------------------------
ln -v -s $DIR/.bashrc $TARGET/.bashrc

# Link correct prompt setup file
if [[ $OSTYPE == *darwin* ]]; then
    ln -v -s $DIR/.bash_ps1.osx $TARGET/.bash_ps1
else
    ln -v -s $DIR/.bash_ps1 $TARGET/.bash_ps1
fi


# --------------------------------------------------------
# Setup vim
# --------------------------------------------------------

ln -v -s $DIR/.vimrc $TARGET/.vimrc
ln -v -s $DIR/.vim $TARGET/.vim
git --git-dir=/$DIR/.git --work-tree=$DIR submodule update --init


