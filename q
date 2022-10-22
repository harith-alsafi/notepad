# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.

#export ETS_TOOLKIT=qt4
#export QT_API=pyqt5
export ANDROID_HOME=/opt/Android/Sdk
export ANDROID_AVD_HOME=/opt/Android/.android/avd
export ANDROID_SDK_HOME=
export ANDROID_USER_HOME=/opt/Android/.android
export ANDROID_SDK_ROOT=/opt/Android/Sdk
export PATH=/bin/texlive/2020/bin/x86_64-linux:$PATH
export PATH="$PATH:/bin/flutter/bin"
export PATH=$PATH:/bin/textadept
export MANPATH=/bin/texlive/2020/texmf-dist/doc/man
export INFOPATH=/bin/texlive/2020/texmf-dist/doc/info
export NVM_DIR="$HOME/.nvm"
# export JAVA_HOME=/usr/local/java/
export JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin
export PATH="${PATH}:${ANDROID_HOME}tools/:${ANDROID_HOME}platform-tools/"
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"


# Markdown rendering 
fi
rmd () {

	  pandoc $1 | lynx -stdin
}

# Term colors 
export TERM="xterm-256color"

# If you come from bash you might have to change your $PATH.
#export PATH=$HOME/bin:/usr/local/bin:$PATH
#PROMPT='%{$fg[yellow]%}[%D{%f/%m/%y} %D{%L:%M:%S}] '$PROMPT 

#Cutsom aliases:
# File transfers
#transfer() {
#    curl --progress-bar --upload-file "$1" https://transfer.sh/$(basename $1) | tee /dev/null;
#}
#alias transfer=transfer

# Python -gui with pyqt 
#gui() {
#	pyuic5 -x "$1" -o pyqt5gui.py
#}
#alias gui=gui

# System resources
alias cpu='watch -n.1 "cat /proc/cpuinfo | grep \"^[c]pu MHz\""' # cpu freq
alias net='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -' # internet speed 
alias dspeed='sudo hdparm -Tt' # drive speed (use with /dev/sd..) 

# Directories
alias gh='cd /media/harithalsafi/DATA/Media/Documents/Coding/Projects'
alias apps='cd /usr/share/applications/'
alias cod='cd  /media/harithalsafi/DATA/Media/Documents/Coding/'
alias d='cd /media/harithalsafi/DATA'
alias uni='cd /media/harithalsafi/DATA/Education/University/University-Year-2'

pixel-emulator()
{
 nohup /opt/Android/Sdk/emulator/emulator -avd Pixel_6_Pro_API_30 > /dev/null &
}

# search function 
search()
{
	find -L "$1" -name "$2"
}

# Files
alias upload='woof'
alias docs='nohup libreoffice --writer'
alias pdf='nohup qpdfview'
alias html='lynx'
alias img='viewnior'
alias to-pdf='unoconv -f pdf'
alias txt='/home/harithalsafi/Others/textadept_10.8.x86_64/textadept'

# System comands and tools
alias location='/home/harithalsafi/custom-scripts/location.sh'
alias repo='/home/harithalsafi/custom-scripts/git.sh'
alias pkgs='sudo apt list --installed' # list of packages
alias bt-on='bluetooth on && echo connect 14:BD:61:24:BE:CB | bluetoothctl'
alias psave='sudo /home/harithalsafi/custom-scripts/powersave2.sh'
alias pmid='sudo /home/harithalsafi/custom-scripts/middle.sh'
alias pperf='sudo /home/harithalsafi/custom-scripts/performance.sh'
alias mod='sudo /home/harithalsafi/custom-scripts/mount.sh'
alias sthunar='sudo thunar'
alias updates='apt list --upgradable'
alias vpn='sudo openvpn /home/harithalsafi/custom-scripts/VPNBook.com-OpenVPN-FR1/vpnbook-fr1-udp25000.ovpn'
alias cache='/home/harithalsafi/custom-scripts/clear-cache.sh'
alias wacom='/home/harithalsafi/custom-scripts/wacom.sh'
alias compile='sudo chmod 755'
alias vcon="vim ~/.vimrc"
alias zcon='vim ~/.zshrc'
alias h='history'
alias c="clear"
alias ch='echo "" > ~/.zsh_history & exec $SHELL -l' # clear history 
alias pcon='vim ~/.p10k.zsh'
alias install='sudo apt-get install'
alias :q='exit'
alias uninstall='sudo apt-get --purge autoremove'
alias purge='sudo aptitude purge'
alias remove='sudo apt autoremove'
alias e='nohup thunar . > /dev/null &'
alias night='nohup redshift-gtk -t 6500:4000 . > /dev/null &' # night shift 
alias ssh1='ssh linux@192.168.0.193' # ssh to hack 
alias ssh2='ssh harithalsafi@192.168.0.178' # ssh to local server 
alias ssh3='ssh comp-pc3023' #uni 
alias pip3.6='python3 -m pip'
alias pip2.7='python -m pip'
alias cam_off='sudo modprobe -r uvcvideo'
alias cam_on='sudo modprobe -i uvcvideo'
alias plt='matlab -nodesktop'
# 'octave --no-gui --persist -q'
alias pyth='ipython3 -i /media/harithalsafi/DATA/Media/Documents/Coding/Python/computational-science/ipython/pyth.py'
 alias jup='jupyter-notebook /media/harithalsafi/DATA/Media/Documents/Coding/Python/computational-science/ipython/general.ipynb'
alias lc='colorls'

# Path to your oh-my-zsh installation.
export ZSH="/home/harithalsafi/.oh-my-zsh"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="powerlevel9k/powerlevel9k"
ZSH_THEME="agnoster"

# Custom configs:

# History in cache directory:
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
#COMPLETION_WAITING_DOTS="true"

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
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    colorize
    copydir
    copyfile
    cp
    )

source $ZSH/oh-my-zsh.sh
# ZSH_DISABLE_COMPFIX="true"
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
source ~/path/to/fsh/fast-syntax-highlighting.plugin.zsh
# source //zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.

# Original Con 
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme
source ~/powerlevel10k/powerlevel10k.zsh-theme

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm






# added by travis gem
[ ! -s /home/harithalsafi/.travis/travis.sh ] || source /home/harithalsafi/.travis/travis.sh
