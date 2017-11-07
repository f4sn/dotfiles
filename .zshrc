# http://mollifier.mit-license.org/

# 環境変数
export LANG=ja_JP.UTF-8
export PATH=$HOME/.nodebrew/current/bin:$PATH

# 色を使用出来るようにする
autoload -Uz colors
colors

# emacs 風キーバインドにする
bindkey -e

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt bang_hist
setopt extended_history


PROMPT="
%(?.%{${fg[green]}%}.%{${fg[red]}%})[%n@%m] %{${reset_color}%}
 > "
RPROMPT='%{$fg[cyan]%}[%~]%{${reset_color%}'
SPROMPT="%{${fg[yellow]}%}  > %r ? [nyae]:%{${reset_color}%}"


# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# 補完
# 補完機能を有効にする
#
#autoload predict-on
#predict-off
source $HOME/.zsh/auto-fu.zsh/auto-fu.zsh
function zle-line-init(){
    auto-fu-init
}
zle -N zle-line-init
zstyle ':auto-fu:highlight' input fg=white
zstyle ':auto-fu:highlight' completion fg=white
zstyle ':auto-fu:var' postdisplay ''

autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

#Shift-ctrで補完のバック
bindkey "^[[Z" reverse-menu-complete

#矢印インターフェイス
zstyle ':completion:*' menu select

#補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

zstyle ':completion:*:default' menu select=2

# 補完関数の表示を強化する
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
#zstyle ':completion:*' completer
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '-----%B%b%d-----'
zstyle ':completion:*:options' description 'yes'
#
# zstyle ':completion:*:messages' format ''
# zstyle ':completion:*:warnings' format ''
# zstyle ':completion:*:descriptions' format ''
# zstyle ':completion:*:options' description 'yes'
# # マッチ種別を別々に表示
 zstyle ':completion:*' group-name ''
########################################
# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'
setopt auto_list  # 補完候補が複数ある時に、一覧表示
setopt auto_menu  # 補完候補が複数あるときに自動的に一覧表示する
setopt complete_in_word #文字ごと補完
function _update_vcs_info_msg() {
   LANG=en_US.UTF-8 vcs_info
#    RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg


#######################################
# オプション
# 日本語ファイル名を表示可能にする
#
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

#あいまい補完
setopt correct

#PCRE正規表現
#setopt re_match_pcre
#うごかない

#表示の度に評価と置換を行う
setopt prompt_subst

#######################################
# キーバインド

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward

########################################
# エイリアス

alias la='ls -a'
alias ll='ls -l'
alias lla='ls -al'
alias lal='ls -al'
alias ccd='popd'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'
alias dxrp='dxrp5 --nojruby run'
alias rp5='rp5 --nojruby run'
alias run='ruby .run.rb '

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
#######################################
# Color
#######################################
#色の設定
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS='di=32:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors \
'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

export CLICOLOR=1
alias ls='ls -G -F'

#vim:set ft=zsh:
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# KBTLAB等のofficeでproxyを自動で切り替える
alias nswitch="source ~/.switch_proxy"
nswitch

# brew docotr曰く必要
export PATH="/usr/local/sbin:$PATH"

#opencv周り
#export PATH="/usr/local/Cellar/opencv3/bin:$PATH"
export PATH="/usr/local/opt/opencv3/bin:$PATH"
export PATH="/usr/local/opt/opencv3/include:$PATH"
export CPATH="${CPATH}:/usr/local/opt/opencv3/include"
export LIBRARY_PATH="${LIBRARY_PATH}:/usr/local/opt/opencv3/lib"

#tmuxの自動起動
if [ $SHLVL = 1 ]; then
	alias tmux="tmux attach || tmux new-session \; source-file ~/.tmux/session"
	tmux attach || tmux new-session \; source-file ~/.tmux/session
fi
