
###
# Setup command search path
typeset -U path
path=(/usr/local/bin /usr/local/sbin $path ~/.script ~/.dotfiles/bash)
cdpath=(~ ~/Documents ~/Documents/pgm)

# functions path
fpath=($fpath /usr/local/share/zsh-completions ~/.dotfiles/zsh/function)

# export shell variable
case `uname` in
  Darwin ) # mac os
    export CC=clang
    export CXX=clang++
    ;;
  Linux )
    export CC=gcc
    export CXX=g++
    ;;
esac
export EDITOR=vim
###

case `uname` in
  Linux )
    # ruby
    if which rbenv > /dev/null; then
      path=(~/.rbenv/shims $path)
      eval "$(rbenv init - zsh)"
    fi

    # python
    if which pyenv > /dev/null; then
        export PYENV_ROOT="${HOME}/.pyenv"
        # export PATH=${PYENV_ROOT}/shims:${PATH}
        eval "$(pyenv init -)";
    fi
esac

# todo
if which todo > /dev/null; then
  todo -l
fi

