
### Alias ###
. ~/.config/fish/aliases.fish


### Path ###

if not contains /usr/local/bin $PATH
  set -x PATH /usr/local/bin $PATH
end

# PATH
set user_paths \
  $HOME/.npm-packages/bin \
  $PATH $HOME/.dotfiles/bin \
  $PATH $HOME/local/bin \
  $PATH $HOME/picnic-tools/bin

for i in $user_paths
  if not contains $i $PATH
    set PATH $PATH $i
  end
end

# CDPATH
set user_cdpath \
  $HOME \
  $HOME/Documents \
  $HOME/Documents/pgm

for i in $user_cdpath
  if not contains $i $CDPATH
    set CDPATH $CDPATH $i
  end
end


### Prompt ###

function fish_prompt -d "Write out the prompt"
  set -l color $fish_color_cwd
  if test $status -ne 0
    set color $fish_color_error
  end

  printf '%s%s>%s ' \
    (prompt_pwd) (set_color $color) (set_color normal)
end

function fish_right_prompt -d "Write out the right prompt"
  test -d "$PWD/.git"; or return

  # branch name
  set -l head (git symbolic-ref HEAD 2> /dev/null)
  test -z $head; and return
  set -l branch (basename $head)
  test -z $branch; and return

  # set color
  set st (git status 2> /dev/null)
  if echo "$st" | grep --quiet "nothing to"
    set color green
  else if echo "$st" | grep --quiet "nothing added"
    set color yellow
  else if echo "$st" | grep --quiet "Untracked files"
    set color red --bold
  else
    set color red
  end

  printf '%s%s%s ' \
    (set_color $color) $branch (set_color normal)
end


### Useful Functions ###

function mkdircd
  command mkdir -p "$argv[1]"; and cd "$argv[1]"
end

function path
  set -l IFS ':'
  for p in $PATH
    echo $p
  end
end

function cdpath
  set -l IFS ':'
  for p in $CDPATH
    echo $p
  end
end

function extract
  if not test -f "$argv[1]"
    echo "'$1' is not a valid file"
    return
  end

  switch "$argv[1]"
  case '*.tar.bz2'
    tar xjf "$argv[1]"
  case '*.tar.gz'
    tar xzf "$argv[1]"
  case '*.bz2'
    bunzip2 "$argv[1]"
  case '*.rar'
    unrar e "$argv[1]"
  case '*.gz'
    gunzip "$argv[1]"
  case '*.tar'
    tar xf "$argv[1]"
  case '*.tbz2'
    tar xjf "$argv[1]"
  case '*.tgz'
    tar xzf "$argv[1]"
  case '*.zip'
    unzip "$argv[1]"
  case '*.Z'
    uncompress "$argv[1]"
  case '*.7z'
    7z x "$argv[1]"
  case '*'
    echo "'$1' cannot be extracted via extract()"
  end
end
