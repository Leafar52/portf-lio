#!/bin/bash
cd "$(dirname "$0")" || exit 1
mkdir -p img
CHROME=""
for c in "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
         "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser" \
         "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge"; do
  [ -x "$c" ] && CHROME="$c" && break
done
[ -z "$CHROME" ] && { echo "Chrome nao encontrado."; read -r -p "Enter..." _; exit 1; }

PROFILE="$(mktemp -d)"
echo "Gerando a que faltou (Thaisa Leal), com mais tempo de espera..."
"$CHROME" --headless=new --disable-gpu --hide-scrollbars \
          --user-data-dir="$PROFILE" \
          --window-size=1200,800 --virtual-time-budget=25000 \
          --screenshot="img/08-thaisa-leal.png" "https://novo.thaisaleal.com.br/" 2>&1 | grep -v "^$"
rm -rf "$PROFILE"

if [ -f "img/08-thaisa-leal.png" ]; then
  echo "ok -> img/08-thaisa-leal.png"
else
  echo "FALHOU de novo. Me avise que eu troco a abordagem."
fi
read -r -p "Enter para fechar..." _
