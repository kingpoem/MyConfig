#!/bin/bash
# set -eux

declare -r HOSTNAME=$(hostname)
declare -r CURRENT_BRANCH=$(git branch --show-current)
declare -r ROOT_DIR=$(git rev-parse --show-toplevel)
declare -x DIR="all"
declare -x FILE=""

declare -x -a -r git_config=("git_" ".gitconfig")
declare -x -a -r lvim_config=("lvim_" ".config/lvim/config.lua" ".config/lvim/lazy-lock.json")
declare -x -a -r tmux_config=("tmux_" ".tmux.conf")
declare -x -a -r zsh_config=("zsh_" ".zshrc")

function init() {
    local dir="$1"
    if [ ! -d "$1" ]; then
        mkdir $1
    fi
    if [ ! -d "$( dirname "$2")" ]; then
        mkdir -p $( dirname "$2" )
    fi
    if [ ! -f "$2" ]; then
        touch $2
    fi
    ln -is $(git rev-parse --show-toplevel)/${1}/$( basename ${2} ) ~/${2} 
    if [ $? -eq 0 ]; then
        echo -e "\e[32mInitializing $2 configuration successfully!\e[0m"
    fi
}

function update() {
    local dir="$1"
    if [ ! -d "$1" ]; then
        mkdir $1
    fi
    cp -i ~/${2} ${ROOT_DIR}/${1}/$( basename ${2} )
    if [ $? -eq 0 ]; then
        echo -e "\e[32mUpdating $2 configuration successfully!\e[0m"
    fi
}

# check if it is a git repository
if [ ! -d ".git" ]; then
    echo "\e[31mThis is not a git repository, please run this script in the root directory of your configuration!\e[0m"
    exit 1
fi

# ==================================Git Branch Management==================================================
if git show-ref --verify --quiet refs/heads/"$HOSTNAME"; then
    if [ "$CURRENT_BRANCH" != "$HOSTNAME" ]; then
        git switch "$HOSTNAME"
        echo -e "\e[31mBranch "$HOSTNAME" already exists, switch to it successfully!\e[0m"
        echo -e "\e[31mIf you want to name it differently, please remove this block in config.sh: `echo $LINENO` and run 'git branch -m CURRENT_BRANCH your_branch_name' manually!\e[0m"
    fi
else
    git switch -c $HOSTNAME
    echo -e "\e[31mBranch `$HOSTNAME` is created and switch to it successfully!\e[0m"
fi
# ==========================================================================================================

while getopts "iud::" opt; do
    case ${opt} in
        i)
            declare -x -r TAG="init"
            ;;
        u)
            declare -x -r TAG="update"
            ;;
        d)
            DIR=${OPTARG}
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
    esac
done

if [[ "$DIR" == "all" ]]; then
    echo -e "\e[32mAll files will ${TAG}!\e[0m"
    ${TAG} "${git_config[0]}" "${git_config[1]}"
    ${TAG} "${lvim_config[0]}" "${lvim_config[1]}"
    ${TAG} "${lvim_config[0]}" "${lvim_config[2]}"
    ${TAG} "${tmux_config[0]}" "${tmux_config[1]}"
    ${TAG} "${zsh_config[0]}" "${zsh_config[1]}"
elif [[ "$DIR" == "git" ]]; then
    echo -e "\e[32m请选择要 ${TAG} 的 git 配置文件：\e[0m"
    echo -e "\e[32m1. .gitconfig\e[0m"
    read -p "请输入序号：" num

    for (( i=0; i<${#num}; i++ )); do
        char="${num:$i:1}"
        case $char in 
            1)
                ${TAG} "${git_config[0]}" "${git_config[1]}"
                ;;
            *)
                echo "Invalid option: $char" >&2
                exit 1
                ;;
        esac
    done
elif [[ "$DIR" == "lvim" ]]; then
    echo -e "\e[32m请选择要 ${TAG} 的 lvim 配置文件：\e[0m"
    echo -e "\e[32m1. .config/lvim/config.lua\e[0m"
    echo -e "\e[32m2. .config/lvim/lazy-lock.json\e[0m"
    read -p "请输入序号：" num

    for (( i=0; i<${#num}; i++ )); do
        char="${num:$i:1}"
        case $char in 
            1)
                ${TAG} "${lvim_config[0]}" "${lvim_config[1]}"
                ;;
            2)
                ${TAG} "${lvim_config[0]}" "${lvim_config[2]}"
                ;;
            *)
                echo "Invalid option: $char" >&2
                exit 1
                ;;
        esac
    done
elif [[ "$DIR" == "tmux" ]]; then
    echo -e "\e[32m请选择要 ${TAG} 的 tmux 配置文件：\e[0m"
    echo -e "\e[32m1. .tmux.conf\e[0m"
    read -p "请输入序号：" num

    for (( i=0; i<${#num}; i++ )); do
        char="${num:$i:1}"
        case $char in 
            1)
                ${TAG} "${tmux_config[0]}" "${tmux_config[1]}"
                ;;
            *)
                echo "Invalid option: $char" >&2
                exit 1
                ;;
        esac
    done
elif [[ "$DIR" == "zsh" ]]; then
    echo -e "\e[32m请选择要 ${TAG} 的 zsh 配置文件：\e[0m"
    echo -e "\e[32m1. .zshrc\e[0m"
    read -p "请输入序号：" num

    for (( i=0; i<${#num}; i++ )); do
        char="${num:$i:1}"
        case $char in 
            1)
                ${TAG} "${zsh_config[0]}" "${zsh_config[1]}"
                ;;
            *)
                echo "Invalid option: $char" >&2
                exit 1
                ;;
        esac
    done
else
    echo "Invalid option: $DIR" >&2
    echo "Please choose from: git, lvim, tmux, zsh"
    exit 1
fi
