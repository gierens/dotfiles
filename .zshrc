# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.cargo/bin:$HOME/.local/bin:$HOME/.local/share/gem/ruby/3.0.0/bin/:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
if [[ $(date +%H) -ge 8 && $(date +%H) -lt 18 ]]; then
    ZSH_THEME="agnoster-light"
else
    ZSH_THEME="agnoster"
fi

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    vi-mode
    fzf
    git
    history-substring-search
    colored-man-pages
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-z
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='nvim'

# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000000
export SAVEHIST=1000000000
setopt EXTENDED_HISTORY

# Pinentry
export PINENTRY_USER_DATA=USE_CURSES=1

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
# Emacs style
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
# Vi style:
# zle -N edit-command-line
# bindkey -M vicmd v edit-command-line

# load vim gruvbox colors
~/.nvim-gruvbox/gruvbox_256palette.sh

# configure less pager
LESS="FRX"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

view_pdf() {
    if [ -z "$1" ]; then
        echo "No file given"
        return 1
    fi
    nohup evince $1 > /dev/null 2>&1 &
}

alacritty_theme() {
    FILE="${HOME}/.config/alacritty/alacritty.toml"
    THEME=$1
    sed -i --follow-symlinks "s/themes\/.*\.toml/themes\/${THEME}.toml/g" $FILE
}

aerc_theme() {
    FILE="${HOME}/.config/aerc/aerc.conf"
    THEME=$1
    sed -i --follow-symlinks "s/^styleset-name=.*$/styleset-name=${THEME}/g" $FILE
}

theme() {
    if [ -z "$1" ]; then
        echo "No theme given"
        return 1
    fi
    if [ "$1" != "light" ] && [ "$1" != "dark" ]; then
        echo "Invalid theme, must be 'light' or 'dark'"
        return 1
    fi
    case $1 in
        light)
            alacritty_theme "gruvbox_material_medium_light"
            aerc_theme "gruvbox-light"
            ;;
        dark)
            alacritty_theme "gruvbox_dark"
            aerc_theme "gruvbox-dark"
            ;;
    esac
}

git_quick_add() {
    for f in $(git ls-files --modified --exclude-standard --others)
    do
        git add $f; git commit --sign --message "feat($(dirname $f)): add $(basename $f)"
    done
}

cp_latest_screenshot() {
    if [ -z "$1" ]; then
        echo "No destination given"
        return 1
    fi
    cp "$(ls -t $(xdg-user-dir PICTURES)/Screenshots/* | head -n 1)" $1
}

mv_latest_screenshot() {
    if [ -z "$1" ]; then
        echo "No destination given"
        return 1
    fi
    mv "$(ls -t $(xdg-user-dir PICTURES)/Screenshots/* | head -n 1)" $1
}

open_project() {
    if [ -z "$1" ]; then
        echo "No destination given"
        return 1
    fi
    if [ -n "$TMUX" ]; then
        echo "Already inside a TMUX session."
        return 1
    fi
    if [ ! -d "$1" ]; then
        echo "Path does not exist or is no directory."
        return 1
    fi

    dir="$1"
    name=$(basename "$dir")
    if [ -n "$2" ]; then
        name="$2"
    fi

    [[ $(tmux attach-session -t "$name" 2>/dev/null ) ]] && { return }

    cd "$dir"
    tmux new-session -d -s "$name"

    tmux rename-window -t "$name" "nvim"
    tmux send-keys -t "$name" "nvim ." C-m

    tmux new-window -t "$name"
    tmux rename-window -t "$name" "bash"

    tmux attach-session -t "$name"
}

alias v="nvim"
alias t="tmux"
alias e="eza"
alias c="cargo"
alias m="aerc"
alias z="zig"
alias zl="zola"
alias hx="helix"
alias o="open_project"
alias recmd5="~/projects/recmd5/recmd5.sh"
alias view="view_pdf"
alias gitgraph="git log --graph --oneline --all --decorate"
alias cinema="~/projects/cinema/cinema.sh"

export GPG_TTY=$(tty)
