#!/usr/bin/env bash
set -euo pipefail

pacman_packages=(
  # ── Hyprland ────────────────────────────────────────────────────────
  hyprland hyprlock awww grim slurp swaync waybar rofi hyprshot
  xdg-desktop-portal-hyprland xdg-desktop-portal xdg-desktop-portal-gtk

  # ── Sistema: red, bluetooth, audio ──────────────────────────────────
  pipewire wireplumber wiremix bluez bluez-utils
  pipewire-alsa pipewire-jack pipewire-pulse

  # ── Codecs multimedia ───────────────────────────────────────────────
  gst-plugin-pipewire gst-libav libva-mesa-driver libva-utils
  gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly

  # ── Apps y utilidades ───────────────────────────────────────────────
  ghostty yazi loupe ffmpeg mpv qbittorrent 7zip
  steam gamescope lib32-mesa lib32-vulkan-radeon

  # ── Qt & Display Manager ────────────────────────────────────────────
  sddm qt5ct qt6ct qt5-wayland qt6-wayland

  # ── Fuentes ─────────────────────────────────────────────────────────
  ttf-jetbrains-mono-nerd noto-fonts noto-fonts-cjk ttf-dejavu

  # ── Temas, apariencia y misceláneo ──────────────────────────────────
  adw-gtk-theme kvantum-qt5 cliphist nwg-look
)

aur_packages=(
  # ── Apps ────────────────────────────────────────────────────────────
  spotify zen-browser-bin onlyoffice-bin

  # ── Fuentes Windows ─────────────────────────────────────────────────
  ttf-segoe-ui-variable ttf-ms-fonts ttf-vista-fonts

  # ── Temas e íconos ──────────────────────────────────────────────────
  sddm-astronaut-theme apple_cursor whitesur-icon-theme
)

echo "==> Installing pacman packages..."
sudo pacman -S --noconfirm --needed "${pacman_packages[@]}"

echo "==> Installing AUR packages..."
yay -S --noconfirm "${aur_packages[@]}"
