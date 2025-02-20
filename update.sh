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
        echo -e "\e[32mIf you want to name it differently, please remove this block in update.sh and run `git branch -m $CURRENT_BRANCH your_branch_name` manually!\e[0m"
    fi
else
    git switch -c $HOSTNAME
    echo -e "\e[32mBranch `$HOSTNAME` is created and switch to it successfully!\e[0m"
fi
# ==========================================================================================================

# usage: update.sh {git|lvim|tmux|zsh|all} path
function update() {
    if [ ! -d $2 ]; then
        mkdir ${2}
    fi
    cp -i ~/${1} ${ROOT_DIR}/${2}/$( basename ${1} )
    echo -e "\e[32mUpdating $1 configuration successfully!\e[0m"
}

case $1 in
    git)
        update .gitconfig git_
        ;;
    lvim)
        update .config/lvim/config.lua lvim_
        update .config/lvim/lazy-lock.json lvim_
        ;;
    tmux)
        update .tmux.conf tmux_
        # if [ -d ~/.tmux/plugins/tpm/ ] ; then
        #     update .tmux/plugins/tpm/tpm tmux_
        # fi
        ;;
    zsh)
        update .zshrc zsh_
        ;;
    # nvim)
    #     update .config/nvim nvim_
    #     ;;
    all)
        update .gitconfig git_
        update .config/lvim/config.lua lvim_
        update .config/lvim/lazy-lock.json lvim_
        update .tmux.conf tmux_
        update .zshrc zsh_
        # update .config/nvim nvim_
        ;;
    *)
        echo -e "\e[31mUsage: bash update.sh {git|lvim|tmux|zsh|all}\e[0m"
        ;;
esac