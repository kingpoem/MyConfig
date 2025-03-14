# export env variable
export VERILATOR_ROOT="/usr/local"
export NPC_HOME=/home/poem/app/github/ysyx-workbench/npc
export AM_HOME=/home/poem/app/github/ysyx-workbench/abstract-machine
export NEMU_HOME=/home/poem/app/github/ysyx-workbench/nemu
export VCPKG_ROOT="$HOME/app/vcpkg"
export VCPKG="$HOME/app/vcpkg/vcpkg"
export HEXO="$HOME/app/hexo/node_modules/.bin"
export LOCAL="$HOME/.local/bin"
export CONDA="/opt/anaconda/bin"
export CXX="/usr/bin/g++"
export BIN="$HOME/bin:/usr/local/bin"
export CURL_CA_BUNDLE="/etc/ssl/certs/ca-certificates.crt"
export JAVAC_HOME="/usr/lib/jvm/java-23-openjdk/bin"
export QSYS_ROOTDIR="/home/poem/.cache/paru/clone/quartus-free/pkg/quartus-free-quartus/opt/intelFPGA/23.1/quartus/sopc_builder/bin"

# ccache
# export CC="ccache gcc"
# export CXX="ccache g++"
# export CCACHE_MAXSIZE=10G
# export CCACHE="/usr/lib/ccache/bin"
# export CCACHE_DIR=".ccache"

# proxy
export http_proxy="http://127.0.0.1:7897"
export https_proxy="http://127.0.0.1:7897"
export GITHUB_PROXY="https://moeyy.cn/gh-proxy"

# help seek exe; if not add them to PATH, then can not use them in command
export PATH="$CCACHE:$PATH:$VCPKG_ROOT:$VCPKG:$HEXO:$LOCAL:$CXX:$BIN:$CURL_CA_BUNDLE:$JAVAC_HOME:$QSYS_ROOTDIR:$VERILATOR_ROOT"

# env variable
ZSH=/usr/share/oh-my-zsh/
ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir -p $ZSH_CACHE_DIR
fi

# xmake
test -f "/home/poem/.xmake/profile" && source "/home/poem/.xmake/profile"

# auto start tmux
if [ -z "$TMUX" ]
then
  tmux attach -t "1" || tmux new -s "1"
fi

# ZSH Theme
# https://github.com/ohmyzsh/ohmyzsh/wiki/themes
ZSH_THEME="agnoster"

# change directories
alias ..="cd .."
alias ap="cd ~/app && eza -la"
alias down="cd ~/Downloads && eza -la"
alias github="cd ~/app/github && eza -la"
alias ob="cd ~/app/obsidian"
alias vsc="cd ~/app/vscode && eza -la"
alias blog="cd ~/app/github/blog"

# daily use
alias l="eza --long --all"
alias make="make -j $(nproc)"
alias lg="lazygit"
alias cl="sudo clear"
alias q="exit"
alias dmesg="sudo dmesg"
alias del="rm -rf"
alias mv="mv -i"
alias his="history"
alias hexo_="blog && hexo clean && hexo generate && hexo server &"
alias copy="$HOME/app/copy-paste"
c() {
    if [ -d "$1" ]; then
        cd "$1" && eza -la
    else
        echo "目录不存在: $1"
    fi
}
color_test() {
  awk 'BEGIN{
      for(col=0; col<256; col++) {
          printf "\033[48;2;%d;%d;%dm", col,col,col
          printf "%4d", col
          printf "\033[0m"
      }
      printf "\n"
  }'
}

# configuration

## normal configuration
alias zshc="lvim ~/.zshrc && source ~/.zshrc"
alias omzc="lvim ~/.oh-my-zsh && source ~/.zshrc"
alias vimc="lvim ~/.vimrc && source ~/.vimrc"
alias tmuxc="lvim ~/.tmux.conf && source ~/.tmux.conf 2>/dev/null"
alias gitc="lvim ~/.gitconfig"
alias gdbc="lvim ~/.gdbinit"
alias bashc="lvim ~/.bashrc"
alias lv="/home/poem/.local/bin/lvim"

## cpp configuration
alias Bcmake="cmake -B build"
alias bcmake="cmake --build build 2>&1 | tee build/build.log"

## pacman configuration
alias qs="pacman -Qs"
alias get="sudo pacman -S"
alias syu="sudo pacman -Syu --quiet --noconfirm 2>/dev/null"
alias ss="pacman -Ss"
alias ql="pacman -Ql"
alias pacmanc="sudo /home/poem/.local/bin/lvim /etc/pacman.conf"
alias scc="sudo pacman -Scc --noconfirm && paru -Scc --noconfirm && sudo rm -rf /boot/initramfs-linux-fallback.img"

## conda configuration
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1
alias acti="source /opt/anaconda/bin/activate"
alias act="conda activate"

## docker configuration
alias docker-start="sudo systemctl start docker.socket"
alias docker-stop="sudo systemctl stop docker.socket"
alias docker="sudo docker"

alias rv64="riscv64-linux-gnu-gcc"
alias tmuxn="tmux attach -t '1' || tmux new -s '1'"
alias remake="rm -rf build && cmake -B build && cmake --build build -j $(nproc)"
alias rebuild="cmake --build build -j $(nproc)"
alias kills="tmux kill-session -t"
alias make_llvm='cmake -DLLVM_ENABLE_PROJECTS="clang;lld;llvm" -DCMAKE_BUILD_TYPE=Debug -G "Unix Makefiles" ../llvm'
alias difflog="make --debug=v > file1.log && make -d > file2.log && vimdiff file1.log file2.log && rm -rf file1.log file2.log"

# plugins
plugins=(
    git
    autojump
    zsh-syntax-highlighting
    colorize
)

source $ZSH/oh-my-zsh.sh

# vi mode
bindkey -v

## show block or line
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
        echo -ne '\e[2 q'
    elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} == '' ]] || [[ $1 == 'block' ]]; then
        echo -ne '\e[6 q'
    fi
}

## show -- NORMAL -- or -- INSERT --
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}

zle -N zle-line-init      # 注册为Zsh行编辑的初始化函数
zle -N zle-keymap-select  # 注册为Zsh行编辑模式改变时的回调函数

setopt no_nomatch  
# 如果使用通配符但没有匹配到任何文本 Zsh不会报错 而是保留原始的通配符文本

