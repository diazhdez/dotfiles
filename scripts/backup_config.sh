#!/usr/bin/env bash
set -euo pipefail

# ─────────────────────────────────────────────
#  Detecta la raíz del repo automáticamente
#  sin importar desde dónde se llame el script
# ─────────────────────────────────────────────
dotfiles_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
timestamp=$(date +"%Y%m%d-%H%M%S")
backup_dir="$HOME/.backup-$timestamp"

echo "==> Backing up existing config files before deploying"
echo "==> Backup will be saved to: $backup_dir"
mkdir -p "$backup_dir"

# Targets base
targets=(".zshrc")

# Auto-detecta carpetas en la raíz del repo (excluye scripts/ y carpetas ocultas)
# Esto cubre: colors fontconfig ghostty hypr ohmyposh rofi swaync waybar wlogout yazi
# Si agregas más carpetas al repo en el futuro, se detectan automáticamente
while IFS= read -r -d '' dir; do
    dirname="${dir#$dotfiles_root/}"
    targets+=(".config/$dirname")
done < <(find "$dotfiles_root" -mindepth 1 -maxdepth 1 -type d \
    -not -name ".*" -not -name "scripts" -print0 2>/dev/null || true)

# Mover configs existentes al directorio de backup (solo archivos reales, no symlinks)
for target in "${targets[@]}"; do
    src="$HOME/$target"
    if [[ -e "$src" && ! -L "$src" ]]; then
        dest="$backup_dir/$target"
        mkdir -p "$(dirname "$dest")"
        mv "$src" "$dest"
        echo "  -> Backed up: $target"
    fi
done

echo
echo "Backup completed!"
echo
