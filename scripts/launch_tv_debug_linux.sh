#!/bin/bash
# Launch TradingView Desktop on Linux with Chrome DevTools Protocol enabled
# Usage: ./scripts/launch_tv_debug_linux.sh [port]

PORT="${1:-9222}"
if ! [[ "$PORT" =~ ^[0-9]+$ ]] || [ "$PORT" -lt 1024 ] || [ "$PORT" -gt 65535 ]; then
  echo "Error: invalid port '$PORT' (expected an integer between 1024 and 65535)."
  exit 1
fi

# Auto-detect TradingView install location
APP=""
LOCATIONS=(
  "/opt/TradingView/tradingview"
  "/opt/TradingView/TradingView"
  "$HOME/.local/share/TradingView/TradingView"
  "/usr/bin/tradingview"
  "/usr/local/bin/tradingview"
  "/snap/tradingview/current/tradingview"
  "/var/lib/flatpak/app/com.tradingview.TradingView/current/active/files/bin/tradingview"
  "$HOME/.local/share/flatpak/app/com.tradingview.TradingView/current/active/files/bin/tradingview"
)

for loc in "${LOCATIONS[@]}"; do
  if [ -f "$loc" ] && [ -x "$loc" ]; then
    APP="$loc"
    break
  fi
done

# Fallback: which / whereis
if [ -z "$APP" ]; then
  APP=$(which tradingview 2>/dev/null || which TradingView 2>/dev/null)
fi

# Fallback: find in common dirs
if [ -z "$APP" ]; then
  APP=$(find /opt /usr/local /snap "$HOME/.local" -name "tradingview" -o -name "TradingView" -type f -executable 2>/dev/null | head -1)
fi

if [ -z "$APP" ] || [ ! -f "$APP" ]; then
  echo "Error: TradingView not found."
  echo "Checked: /opt/TradingView, ~/.local/share/TradingView, snap, flatpak, PATH"
  echo ""
  echo "If installed elsewhere, run manually:"
  echo "  /path/to/tradingview --remote-debugging-port=$PORT"
  exit 1
fi

# Never force-close TradingView (unsaved work would be lost): ask the user instead.
# pgrep -x matches the exact process name only. The previous `pkill -f "[Tt]rading[Vv]iew"`
# also matched any command line containing "tradingview" (e.g. this project's own
# MCP server in ~/claudeverstradingview, or an editor opened in that folder).
if pgrep -x "tradingview" > /dev/null 2>&1 || pgrep -x "TradingView" > /dev/null 2>&1; then
  echo "TradingView est deja ouvert. Enregistrez votre travail, fermez TradingView,"
  echo "puis relancez ce script."
  exit 1
fi

echo "Found TradingView at: $APP"
echo "Launching with --remote-debugging-port=$PORT ..."
"$APP" --remote-debugging-port="$PORT" &
TV_PID=$!
echo "PID: $TV_PID"

# Wait for CDP to be ready
echo "Waiting for CDP..."
for i in $(seq 1 15); do
  if curl -s "http://localhost:$PORT/json/version" > /dev/null 2>&1; then
    echo "CDP ready at http://localhost:$PORT"
    curl -s "http://localhost:$PORT/json/version" | python3 -m json.tool 2>/dev/null || curl -s "http://localhost:$PORT/json/version"
    exit 0
  fi
  sleep 1
done

echo "Warning: CDP not responding after 15s. TradingView may still be loading."
