# Dot configuration

这是我的 Dot 配置文件管理仓库。通过 `config.sh` 脚本可以实现自动更新配置。所有配置文件路径尽量按照官方和默认配置放置。

## 使用方法

`config.sh` 脚本将根据您的主机名自动创建一个 git 分支供您自行配置。
在该仓库根目录下，通过运行
```bash
bash ./config.sh -i|u -d dot-config-name
```
- `-i` 将项目中的默认配置文件软链接到您的相应配置文件上。
- `-u` 将您自己的配置文件更新到仓库中，供您管理。
- `-d` 指定 dot-config-name，可选值如下：
    - git
    - lvim
    - tmux
    - zsh
    - all 更新所有在上面提到的配置文件

如您有其他需求，欢迎提 issue，或者您可以自行修改脚本。

## 配置文件地址参考

### git

本仓库仅处理全局配置文件，git 配置文件路径如下：
- `/etc/gitconfig` 系统配置文件
- `~/.gitconfig` 用户配置文件
- `.git/config` 局部配置文件

### lvim

- `~/.config/lvim/config.lua` 配置文件编辑
- `~/.config/lvim/lazy-lock.json` 锁定插件

相关配置参考：
[LunarVim][lunarvim]

### tmux

- `~/.tmux.conf` 默认配置文件
- `~/.tmux/plugins/tpm/ ` 插件管理器目录

相关配置参考：
[Tmux Plugin Manager][tpm]

### zsh

- `~/.zshrc`

相关配置参考：
[Oh My Zsh][ohmyzsh]

### gdb

- `/etc/gdb/gdbinit` 系统配置文件
- `~/.gdbinit` 用户配置文件

### nvim

- `~/.config/nvim`
- `config.lua`
- `lua/usr/`

[lunarvim]: https://www.lunarvim.org/
[tpm]: https://github.com/tmux-plugins/tpm
[ohmyzsh]: https://ohmyz.sh/
