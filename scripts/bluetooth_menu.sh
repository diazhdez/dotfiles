#!/usr/bin/env bash
# rofi-bluetooth — Manage Bluetooth connections with rofi
# Requires: bluez, bluez-utils, rofi, libnotify

notify-send "󰂳 Getting list of available Bluetooth devices..."

# ─── Adapter state ────────────────────────────────────────────────────────────
bt_powered=$(bluetoothctl show | awk '/Powered:/ { print $2 }')

if [[ "$bt_powered" == "yes" ]]; then
  toggle="󰂲 Disable Bluetooth"
elif [[ "$bt_powered" == "no" ]]; then
  toggle="󰂱 Enable Bluetooth"
fi

# ─── Scan y lista de dispositivos ────────────────────────────────────────────
declare -a labels macs

if [[ "$bt_powered" == "yes" ]]; then

  # Escaneo de 5 segundos para descubrir dispositivos cercanos
  bluetoothctl --timeout 5 scan on &>/dev/null

  while IFS= read -r line; do
    mac=$(awk '{ print $2 }' <<<"$line")

    # Nombre desde info del dispositivo; fallback al listado
    name=$(bluetoothctl info "$mac" 2>/dev/null |
      sed -n 's/^\s*Name: //p' | head -1)
    [[ -z "$name" ]] && name=$(cut -d' ' -f3- <<<"$line")

    info=$(bluetoothctl info "$mac" 2>/dev/null)

    if grep -q "Connected: yes" <<<"$info"; then
      icon="󰂱" # conectado
    elif grep -q "Paired: yes" <<<"$info"; then
      icon="󰂴" # pareado, no conectado
    else
      icon="󰂯" # nuevo
    fi

    labels+=("$icon $name")
    macs+=("$mac")
  done < <(bluetoothctl devices 2>/dev/null)
fi

# ─── Menú rofi ───────────────────────────────────────────────────────────────
chosen=$(
  {
    echo "$toggle"
    printf '%s\n' "${labels[@]}"
  } |
    uniq |
    rofi -dmenu -i -selected-row 1 -p "Bluetooth " -no-show-icons
)

[[ -z "$chosen" ]] && exit

# ─── Toggle on/off ────────────────────────────────────────────────────────────
if [[ "$chosen" == "󰂱 Enable Bluetooth" ]]; then
  bluetoothctl power on && notify-send "Bluetooth" "Bluetooth habilitado"
  exit
elif [[ "$chosen" == "󰂲 Disable Bluetooth" ]]; then
  bluetoothctl power off && notify-send "Bluetooth" "Bluetooth deshabilitado"
  exit
fi

# ─── Resolver dispositivo elegido → MAC ──────────────────────────────────────
mac=""
for i in "${!labels[@]}"; do
  [[ "${labels[$i]}" == "$chosen" ]] && mac="${macs[$i]}" && break
done

[[ -z "$mac" ]] && notify-send "Bluetooth Error" "Dispositivo no encontrado" -u critical && exit 1

name=$(bluetoothctl info "$mac" | sed -n 's/^\s*Name: //p' | head -1)
[[ -z "$name" ]] && name="Dispositivo desconocido"
info=$(bluetoothctl info "$mac")

success_msg="Conectado a \"$name\"."

# ─── Acción según estado del dispositivo ─────────────────────────────────────
if grep -q "Connected: yes" <<<"$info"; then

  # Conectado → Desconectar o Eliminar
  action=$(printf 'Disconnect\nRemove Device' |
    rofi -dmenu -i -p "  $name " -no-show-icons)

  if [[ "$action" == "Disconnect" ]]; then
    bluetoothctl disconnect "$mac" | grep -i "successful" &&
      notify-send "Bluetooth" "Desconectado de $name"

  elif [[ "$action" == "Remove Device" ]]; then
    bluetoothctl disconnect "$mac" &>/dev/null
    bluetoothctl remove "$mac" &&
      notify-send "Bluetooth" "Dispositivo $name eliminado"
  fi

elif grep -q "Paired: yes" <<<"$info"; then

  # Pareado pero no conectado → Conectar o Eliminar
  action=$(printf 'Connect\nRemove Device' |
    rofi -dmenu -i -p "  $name " -no-show-icons)

  if [[ "$action" == "Connect" ]]; then
    bluetoothctl connect "$mac" | grep -i "successful" &&
      notify-send "Conexión establecida" "$success_msg"

  elif [[ "$action" == "Remove Device" ]]; then
    bluetoothctl remove "$mac" &&
      notify-send "Bluetooth" "Dispositivo $name eliminado"
  fi

else

  # Nuevo dispositivo → parear, confiar y conectar
  notify-send "Bluetooth" "Pareando con $name..." -t 3000
  if bluetoothctl pair "$mac" && bluetoothctl trust "$mac"; then
    bluetoothctl connect "$mac" | grep -i "successful" &&
      notify-send "Conexión establecida" "$success_msg"
  else
    notify-send "Bluetooth Error" "No se pudo parear con $name" -u critical
  fi

fi
