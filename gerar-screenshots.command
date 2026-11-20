#!/bin/bash
# Gera os screenshots do portfolio em img/ usando o Chrome instalado no Mac.
cd "$(dirname "$0")" || exit 1
mkdir -p img

CHROME=""
for c in "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
         "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser" \
         "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge" \
         "/Applications/Chromium.app/Contents/MacOS/Chromium"; do
  [ -x "$c" ] && CHROME="$c" && break
done

if [ -z "$CHROME" ]; then
  echo "Nao achei Chrome, Brave, Edge nem Chromium em /Applications."
  echo "Instale o Google Chrome e rode de novo."
  read -r -p "Enter para fechar..." _
  exit 1
fi
echo "Usando: $CHROME"
echo

shot () {
  echo "-> $1"
  "$CHROME" --headless=new --disable-gpu --hide-scrollbars \
            --window-size=1200,800 --virtual-time-budget=12000 \
            --screenshot="img/$1.png" "$2" >/dev/null 2>&1
  if [ -f "img/$1.png" ]; then echo "   ok"; else echo "   FALHOU"; fi
}

shot 01-ortopedista   "https://drguilhermefeijo.com.br/"
shot 02-kontabio      "https://kontabio.com.br/"
shot 03-biosphere     "https://biosphere.com.br/lp/"
shot 04-medcred       "https://medcredsolucoes.com.br/contemplados-veiculo/"
shot 05-versatilis    "https://marketing.versatilis.com.br/terapeutas/"
shot 06-dental-sante  "https://dentalsante.vercel.app/"
shot 07-coluna-fluida "https://colunafluida.vercel.app/"
shot 08-thaisa-leal   "https://novo.thaisaleal.com.br/"

echo
echo "Pronto. Imagens em img/"
read -r -p "Enter para fechar..." _
