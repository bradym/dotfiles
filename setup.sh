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

    if ([[ -e "$TARGET/$FILENAME" ]] && [[ ! -L "$TARGET/$FILENAME" ]]) || [[ -d "$TARGET/$FILENAME" ]]; then
        OLDNAME=$FILENAME"_backup.$(date +%s)"
        mv "$TARGET/$FILENAME" "$TARGET/$OLDNAME"
        echo "Existing $FILENAME found and renamed to $OLDNAME"
    fi
}

# --------------------------------------------------------
# Setup bash
# --------------------------------------------------------

# Only files that are in this varible will be symlinked
FILES=".aliases
.bash_profile
.bash_prompt
.bashrc
.curlrc
.editorconfig
.exports
.functions
.gitconfig
.gitignore
.hgignore
.hushlogin
.inputrc
.screenrc
.vimrc
.wgetrc"

for file in $FILES
do
    ls -lh $file
    rename_existing $file
    ln -nvfs $DIR/$file $TARGET/$file
done


# --------------------------------------------------------
# Setup vim
# --------------------------------------------------------

# If there's already a .vim folder, rename it
rename_existing .vim

# Install Vundle
git clone https://github.com/gmarik/Vundle.vim.git $TARGET/.vim/bundle/Vundle.vim

# Install other vim plugins
vim +PluginInstall +qall

# Need to install rstcheck to support rst plugin
pip install rstcheck

cd $DIR

# If a symlink exists for .vim it will be modified
ln -nvfs $DIR/.vim $TARGET/.vim
