export ZSH_WAKATIME_PROJECT_DETECTION=true
export VCPKG_ROOT=~/Applications/vcpkg
export PATH=$VCPKG_ROOT:$PATH
export PATH=/home/poem/.local/bin:$PATH

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# conda config
export PATH=/opt/anaconda/bin/conda:$PATH
alias conda_env="source /opt/anaconda/bin/activate"
alias act="conda activate"
alias dea="conda deactivate"

# auto start tmux
# if [ -z "$TMUX" ]
# then
#     tmux attach -t master || tmux new -s master
# fi
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

ZSH=/usr/share/oh-my-zsh/

# Theme
# ZSH_THEME="fox"
# ZSH_THEME="intheloop"
# ZSH_THEME="refined"
# ZSH_THEME="rkj-repos"
ZSH_THEME="agnoster"

alias zshc="lvim ~/.zshrc && source ~/.zshrc"
alias omzc="lvim ~/.oh-my-zsh && source ~/.zshrc"
alias vimc="lvim ~/.vimrc && source ~/.vimrc"
alias tmuxc="lvim ~/.tmux.conf && source ~/.tmux.conf"
alias vic="vi ~/.config/nvim/init.lua"
alias vi="/usr/bin/nvim"
alias lv="/home/poem/.local/bin/lvim"
alias vl="/home/poem/.local/bin/lvim"

alias tmuxn="tmux attach -t master || tmux new -s master"
alias zat="zathura"
alias ffp="ffplay"
alias ffetch="fastfetch"
alias remake="rm -rf build && cmake -B build && cmake --build build"
alias rebuild="cmake --build build"
alias yz="yazi"
alias vd="(neovide&)&"
alias lg="lazygit"
alias cls="clear"
alias cl="clear"
alias sl="ls"
alias lls="ls"
alias tmxu="tmux"
alias docker-start="sudo systemctl start docker.socket"
alias docker-stop="sudo systemctl stop docker.socket"
alias qs="pacman -Qs"
alias get="sudo pacman -S"
alias un="sudo pacman -R"
alias syu="sudo pacman -Syu"
alias ss="pacman -Ss"
alias pacmanc="sudo /home/poem/.local/bin/lvim /etc/pacman.conf"
alias docker="sudo docker"
alias hexo_="npx hexo clean && npx hexo generate && npx hexo server"
alias hexo_d="npx hexo deploy"
alias blog="cd ~/Applications/blog"
alias vsc="cd ~/Applications/vscode/ && ls"
alias dmesg="sudo dmesg"
alias q="exit"
alias kills="tmux kill-session -t"
alias ql="pacman -Ql"
alias del="rm -rf"
alias mv="mv -i"
c() {
    if [ -d "$1" ]; then
        cd "$1" && ls
    else
        echo "目录不存在: $1"
    fi
}
alias ap="cd ~/Applications && ls"
alias his="history"
alias down="cd ~/Downloads && ls"
alias github="cd ~/Applications/vscode/github && ls"
alias cmk="touch CMakeLists.txt"
alias make_llvm='cmake -DLLVM_ENABLE_PROJECTS="clang;lld;llvm" -DCMAKE_BUILD_TYPE=Debug -G "Unix Makefiles" ../llvm'
alias desk="cd ~/Desktop && ls"
alias qqmusic="cd ~/Applications/vscode/github/qqmusic"
alias fox="musicfox"

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

plugins=(
    git
    autojump
    zsh-syntax-highlighting
    zsh-wakatime
)
source $ZSH/oh-my-zsh.sh

#vi mode
bindkey -v

function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
        echo -ne '\e[2 q'
    elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} == '' ]] || [[ $1 == 'block' ]]; then
        echo -ne '\e[6 q'
    fi
}

function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

setopt no_nomatch   # no error report

source /home/poem/.config/broot/launcher/bash/br
# >>> xmake >>>
test -f "/home/poem/.xmake/profile" && source "/home/poem/.xmake/profile"
# <<< xmake <<<
