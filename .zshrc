# ─── Meta ───────────────────────────────────────────────────────
# Ensure running interactively
[[ $- != *i* ]] && return

# ─── History ─────────────────────────────────────────────────────
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_verify
setopt CORRECT

# ─── Keybinds ────────────────────────────────────────────────────
bindkey -e
bindkey '^[[1;5C' forward-word 
bindkey '^[[1;5D' backward-word

# ─── FZF ─────────────────────────────────────────────────────────
eval "$(fzf --zsh)"

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#313244,label:#CDD6F4"

# ─── Zinit ───────────────────────────────────────────────────────
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# ─── Plugins ──────────────────────────────────────────────────
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
    zsh-users/zsh-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
    zsh-users/zsh-completions \
  Aloxaf/fzf-tab

# Completion styling
zstyle ':completion:*' matcher-list 'm:{A-Za-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' fzf-flags --height=17
zstyle ':fzf-tab:complete:*' fzf-preview '
if [[ -n $realpath ]]; then
  case $(file --mime-type --brief "$realpath") in
    inode/directory)
      eza --icons --tree --level=2 --color=always "$realpath"
      ;;
    image/*)
      kitten icat --clear --transfer-mode=memory --unicode-placeholder \
        --stdin=no --place=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0 \
        "$realpath" 2>/dev/null
      ;;
    *)
      bat -n --color=always --line-range :500 "$realpath" 2>/dev/null \
        || file "$realpath"
      ;;
  esac
fi
'

# ─── Aliases ─────────────────────────────────────────────────────
alias ls='eza --icons --color=always'
alias ll='eza --icons --color=always -l'
alias la='eza --icons --color=always -a'
alias lla='eza --icons --color=always -la'
alias lt='eza --icons --color=always -a --tree --level=1'
alias grep='grep --color=always'

# ─── Tools Init ──────────────────────────────────────────────────
export BAT_THEME="base16"
alias bat='bat --paging=never'
alias cat='bat'

# Setup zoxide
eval "$(zoxide init zsh --cmd cd)"

# Initialize Oh-My-Posh
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/usoj.omp.json)"
