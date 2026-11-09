# --- Meta ---
if test "$TERM" != "linux"
  alias ls 'eza --icons auto'
end
if test "$TERM" = "xterm-kitty"
  alias ssh 'kitten ssh'
end

# --- Common ---
alias c 'clear'
alias ff 'c; fastfetch'
alias ffn 'c; fastfetch --config ~/.config/fastfetch/base_config.jsonc'
alias ffa 'c; ff -c all'
alias ng 'cd ~/.config/nvim'
alias hycfg 'find ~/.config/hypr -path "*/.git/*" -prune -o -printf "%P\n" | fzf | xargs -rI {} nvim ~/.config/hypr/"{}"'
alias hg 'cd ~/.config/hypr'
alias fvim 'fzf --preview "cat {}" | xargs -rI {} nvim "{}"'
alias fevim 'fzf -e --preview "cat {}" | xargs -rI {} nvim "{}"'
alias pyenv 'source ~/snakelang/bin/activate.fish'
alias lvim 'NVIM_APPNAME=lazyvim nvim'
abbr -a g++ 'g++ -std=c++26'
alias oc 'opencode'
alias reload 'exec fish'

# ---- System ----
alias off 'loginctl poweroff'
alias re 'loginctl reboot'
alias charge 'lenopow -d'
alias dont 'lenopow -e'

# ---- Listing ----
alias la 'ls -a'
alias l 'ls -lh'
alias ll 'l -a'
alias lt 'ls --tree'
if command -qs cpg; alias cp 'cpg -g'; end
if command -qs mvg; alias mv 'mvg -g'; end
if command -qs ani-cli; alias anime 'ani-cli'; end
if command -qs zoxide
  zoxide init fish | source
end

# ---- Git ----
abbr -a g 'git'
abbr -a gn 'git --no-pager'
abbr -a ga 'git add'
abbr -a gaa 'git add -A'
abbr -a gc 'git clone --depth 1'
abbr -a gcm 'git commit -m'
abbr -a gcam 'git commit -am'
abbr -a gaacm 'git add -A; git commit -m'
abbr -a gp 'git push'
abbr -a gpm 'git push -u origin master'
abbr -a gst 'git status'
abbr -a gs 'git status -sb'
abbr -a grs 'git restore'
abbr -a grst 'git restore -S'

# AUR helper
if command -qs yay
  set -gx aurhelper yay
else if command -qs paru
  set -gx aurhelper paru
else
  set -gx aurhelper ""
end

# ---- Packages ----
if not test -z "$aurhelper"
  alias pl "$aurhelper -Qs"
  alias pa "$aurhelper -Ss"
  alias pc "sudo rm -r /var/cache/pacman/pkg/download*; yes | $aurhelper -Sc"
  alias po "$aurhelper -Qtdq | xargs -ro $aurhelper -Rns"
  alias yin "$aurhelper -S"
  alias in 'sudo pacman -S'
  alias un 'sudo pacman -Rns'
  alias up "command -v flatpak >/dev/null && flatpak update; $aurhelper -Syu"
else if command -qs emerge
  alias pl 'equery l -p'
  alias pa 'emerge -s'
  alias pc 'sudo rm -r /var/cache/distfiles/*'
  alias in 'sudo emerge'
  alias un 'sudo emerge --unmerge'
  alias up 'sudo emerge -uDN --changed-deps --with-bdeps=y @world'
end

# ---- Misc ----
alias mkdir 'mkdir -p'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
