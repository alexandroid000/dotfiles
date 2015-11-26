#
# ~/.profile
#
# Executes everytime you logon (locally, ssh, etc)

export LANG="en_US.UTF-8"
#export TERM="screen-256color"
export VISUAL="/usr/bin/vim"
export EDITOR="/usr/bin/vim"
export PATH="$PATH:/sbin"
export PATH="$PATH:/usr/sbin"
export PATH="$PATH:$HOME/bin"
export GPG_TTY=`tty`

# Specific Environments for Programs
# ==================================

# Python
# ------
export PYTHONPATH="$PYTHONPATH:$HOME/qgl"

# Maude
# -----
export MAUDE_LIB="$HOME/src/maude/src/Main:$HOME/src/maude/full-maude:$HOME/src/maude/MFE/src"

# XDG dirs
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DOWNLOAD_DIR="$HOME/downloads"
#export XDG_DOCUMENTS_DIR="$HOME/documents"
export XDG_MUSIC_DIR="$HOME/media/music"
#export XDG_PICTURES_DIR="$HOME/pictures"
#export XDG_VIDEOS_DIR="$HOME/videos"
#export XDG_SCREENSHOT_DIR="$HOME/media/scrot"

# gitnet!
export gn_dir="$HOME/src/gn"

# weston/wayland
export XDG_RUNTIME_DIR="/tmp/.runtime-${USER}"
mkdir -p "${XDG_RUNTIME_DIR}"
chmod 0700 "${XDG_RUNTIME_DIR}"

# change too-dark blue color to lighter blue
echo -en "\e]P4264bc2" # S_blue
#echo -en "\e]P50d0d0d" # Set S_magenta to grey for vim background
#echo -en "\e]P5d33682" # S_magenta

# Load our aliases files
[[ -f ~/.aliases ]] && source ~/.aliases
