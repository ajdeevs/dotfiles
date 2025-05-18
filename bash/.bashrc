#
# ~/.bashrc
#

eval "$(starship init bash)"
eval "$(zoxide init bash)"
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# alias ls='ls --color=auto'
alias ls='eza'
alias cd='z'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Show cool banner on terminal start
# toilet -f pagga "Welcome AJDEVS"
neofetch
