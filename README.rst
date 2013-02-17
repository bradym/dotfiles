dotfiles
--------

I've been piecing these dotfiles together for several years. I use them on
Linux, OSX and Windows (cygwin, specifically).

Setting up
----------

I recommend not cloning the dotfiles repo directly into your home
directory. Put it in a subdirectory and create symlinks in your home
directory. In fact, I've created a bash script to do just that:

::

    clone git@github.com:bradym/dotfiles.git ~/.dotfiles
    ~/.dotfiles/setup.sh

If you want the symlinks to be created somewhere other than your home
directory, pass in the directory as an argument to setup.sh:

::

    ~/.dotfiles/setup.sh $HOME/symlinks

I included that feature for testing setup.sh, but you may come up with
another reason why you'd want to do that.

Concepts
--------

Everyone does their dotfiles a bit differently, here are some things you'll
want to know if you decide to use mine.

setup.sh
````````

I got sick of having to symlink my dotfiles every time I setup a new
account, so I created setup.sh to take care of that for me. It will backup
existing files before creating new symlinks. 

.bash_ps1
`````````

I like having a consistent bash prompt across my systems, so I've setup
.bash_ps1 and .bash_ps1.osx. They both do the same thing, but .bash_ps1
didn't work correctly on OSX.

setup.sh checks to see if you're on OSX, if you are the ~/.bash_ps1 symlink
will point to ~/.dotfiles/.bash_ps1.osx.

.bash_host
``````````

My .bashrc looks for a .bash_host file and sources it if found. The purpose
of this file is for aliases/settings specific to a server that you don't
want to check into git.

For example, I've got some aliases I use at work for tailing logs that
include file paths specific to a given server. Since it's so specific I
don't want to include them in my .bashrc, so they go in .bash_host.

Vim settings
------------

I use vim every day, so I've spent quite a bit of time tweaking my .vimrc
and finding plugins I like. 

My .vimrc holds settings for vim itself as well as the plugins I use. All
of the plugins are installed using git submodules and pathogen. When you
run setup.sh all of the plugins will be installed.

Adding a plugin
```````````````

You can install plugins however you like, but I suggest you use git
submodules and pathogen as it means you don't have to worry about keeping
the plugins in your git repo updated.

To install a new plugin using a gitmodule:

::

    git submodule add https://github.com/vim-scripts/csslint.vim.git .vim/bundle/csslint.vim

Updating plugins
````````````````

To update your vim plugins:

::

    git submodule -q foreach git pull -q origin master


Removing a plugin
`````````````````

If you want to remove a plugin, you'll need to remove the git submodule see
this `stackoverflow <http://stackoverflow.com/questions/1260748/how-do-i-remove-a-git-submodule#answer-1260982>`_
answer for help.



    

