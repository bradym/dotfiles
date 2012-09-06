#!/bin/bash
# =========================================================
# Setup dotfiles from cloned git repo
# =========================================================

# Where does this script live?
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Where should symlinks be created?
if [[ -z "$1" ]]; then
    TARGET="$HOME"
else
    TARGET=$1
fi

# If $TARGET does not exist, create it.
if [[ ! -d $TARGET ]]; then
    mkdir -v -p $TARGET
fi

# Function to check for existing file and rename
function rename_existing (){
    FILENAME=$1

    if [[ -e "$TARGET/$FILENAME" ]] && [[ ! -L "$TARGET/$FILENAME" ]] || [[ -d "$TARGET/$FILENAME" ]]; then
        OLDNAME=$FILENAME"_backup.$(date +%s)"
        mv "$TARGET/$FILENAME" "$TARGET/$OLDNAME"
        echo "Existing $FILENAME found and renamed to $OLDNAME"
    fi
}


# --------------------------------------------------------
# Setup bash
# --------------------------------------------------------

# Check for existing .bashrc and rename
rename_existing .bashrc

# If a symlink exists for .bashrc, it will be modified 
ln -nvfs $DIR/.bashrc $TARGET/.bashrc

# Link correct prompt setup file
rename_existing .bash_ps1

if [[ $OSTYPE == *darwin* ]]; then
    ln -nvfs $DIR/.bash_ps1.osx $TARGET/.bash_ps1
else
    ln -nvfs $DIR/.bash_ps1 $TARGET/.bash_ps1
fi


# --------------------------------------------------------
# Setup vim
# --------------------------------------------------------

# Check for existing .vimrc and rename
rename_existing .vimrc

# If a symlink exists for .vimrc it will be modified
ln -nvfs $DIR/.vimrc $TARGET/.vimrc

# If .vim folder exists, rename and notify user
rename_existing .vim

# Setup vim plugins
git --git-dir=/$DIR/.git --work-tree=$DIR submodule init
git --git-dir=/$DIR/.git --work-tree=$DIR submodule update 

# If a symlink exists for .vim it will be modified
ln -nvfs $DIR/.vim $TARGET/.vim
