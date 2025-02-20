#!/bin/bash
set -ex

HOSTNAME=$(hostname)
CURRENT_BRANCH=$(git branch --show-current)
ROOT_DIR=$(git rev-parse --show-toplevel)

# check if it is a git repository
if [ ! -d ".git" ]; then
    echo "\e[31mThis is not a git repository, please run this script in the root directory of your configuration!\e[0m"
    exit 1
fi

# ==========================================================================================================
if git show-ref --verify --quiet refs/heads/"$HOSTNAME"; then
    if [ "$CURRENT_BRANCH" != "$HOSTNAME" ]; then
        git switch "$HOSTNAME"
        echo -e "\e[32mBranch `$HOSTNAME` already exists, switch to it successfully!\e[0m"
        echo -e "\e[32mIf you want to name it differently, please remove this block in init.sh and run `git branch -m $CURRENT_BRANCH your_branch_name` manually!\e[0m"
    fi
else
    git switch -c $HOSTNAME
    echo -e "\e[32mBranch `$HOSTNAME` is created and switch to it successfully!\e[0m"
fi
# ==========================================================================================================

# usage: init.sh {git|lvim|tmux|zsh|all} path
function init() {
    if [ ! -e $1 ]; then
        mkdir -p ${1}
    fi
    ln -s ~/${1} $(git rev-parse --show-toplevel)/${2}/$( basename ${1} )
    echo -e "\e[32mInitializing $1 configuration successfully!\e[0m"
}

case $1 in
    git)
        init .gitconfig git_
        ;;
    lvim)
        init .config/lvim/config.lua lvim_
        init .config/lvim/lazy-lock.json lvim_
        ;;
    tmux)
        init .tmux.conf tmux_
        # if [ -d ~/.tmux/plugins/tpm/ ] ; then
        #     init .tmux/plugins/tpm/tpm tmux_
        # fi
        ;;
    zsh)
        init .zshrc zsh_
        ;;
    # nvim)
    #     init .config/nvim nvim_
    #     ;;
    all)
        init .gitconfig git_
        init .config/lvim/config.lua lvim_
        init .config/lvim/lazy-lock.json lvim_
        init .tmux.conf tmux_
        init .zshrc zsh_
        # init .config/nvim nvim_
        ;;
    *)
        echo -e "\e[31mUsage: bash init.sh {git|lvim|tmux|zsh|all}\e[0m"
        ;;
esac