# Guide d'installation pour Claude Code

Ce fichier guide Claude Code (ou tout agent) pour installer et configurer ce serveur MCP TradingView **durci**. Suivez ces étapes dans l'ordre.

## Règles pour l'agent

- **Demandez confirmation à l'utilisateur avant chaque étape** qui installe, modifie la configuration ou lance un programme.
- **Ne modifiez jamais un serveur MCP déjà configuré.** Ajoutez celui-ci sous un nom distinct.
- **Ne fermez jamais TradingView à la place de l'utilisateur.** N'utilisez pas `tv_launch` avec `kill_existing: true` sauf demande explicite.
- N'exécutez pas `npm link`, `npm run test:e2e`, `test:all` ni `test:verbose`.

## Étape 1 : récupérer le code

```powershell
git clone https://github.com/haddadi84farid-wq/claudeverstradingview.git $HOME\claudeverstradingview
```

Si Git n'est pas installé, demandez à l'utilisateur s'il préfère installer Git (`winget install --id Git.Git -e`) ou télécharger le ZIP du fork depuis GitHub.

Si l'utilisateur indique un autre dossier, utilisez-le à la place de `$HOME\claudeverstradingview` dans toutes les étapes suivantes.

## Étape 2 : installer les dépendances

```powershell
cd $HOME\claudeverstradingview
npm ci --ignore-scripts
```

`npm ci` respecte exactement `package-lock.json`, et `--ignore-scripts` bloque les scripts d'installation.

## Étape 3 : règles de trading

`rules.json` contient déjà un exemple neutre. Dites à l'utilisateur :

> « Ouvrez `rules.json` et renseignez votre watchlist (symboles au format TradingView, par ex. `OANDA:XAUUSD`), vos critères de biais et vos règles de risque. C'est ce que le brief matinal utilise chaque jour. »

`morning_brief` ne lit que `rules.json` à la racine du projet ou `~/.kasper/rules.json`.

## Étape 4 : enregistrer le serveur MCP

```powershell
claude mcp add tradingview-desktop --scope user -- node $HOME\claudeverstradingview\src\server.js
```

- Remplacez le chemin si le projet est ailleurs. Utilisez le chemin Windows réel, pas `/Users/...`.
- Ne modifiez pas les fichiers de configuration à la main, et n'écrasez aucun serveur existant.
- Vérifiez ensuite avec `claude mcp list`.

## Étape 5 : lancer TradingView Desktop avec CDP

TradingView doit tourner avec le Chrome DevTools Protocol activé sur le port 9222.

**Windows (recommandé) :** demandez à l'utilisateur d'enregistrer son travail et de fermer TradingView, puis :

```bat
scripts\launch_tv_debug.bat
```

Le script s'arrête avec un message si TradingView est déjà ouvert.

**Lancement manuel :** TradingView doit être fermé.

Windows :
```bat
"%LOCALAPPDATA%\TradingView\TradingView.exe" --remote-debugging-port=9222
```

macOS :
```bash
/Applications/TradingView.app/Contents/MacOS/TradingView --remote-debugging-port=9222
```

Linux :
```bash
/opt/TradingView/tradingview --remote-debugging-port=9222
```

Sur macOS et Linux, vous pouvez aussi utiliser `./scripts/launch_tv_debug_mac.sh` ou `./scripts/launch_tv_debug_linux.sh`. Comme le script Windows, ils s'arrêtent si TradingView est déjà ouvert.

**Avec l'outil MCP :** `tv_launch` fonctionne si TradingView est fermé. Il ne ferme pas une instance ouverte.

## Étape 6 : redémarrer Claude Code

Le serveur MCP n'est chargé qu'au démarrage de Claude Code :

1. Quittez Claude Code.
2. Relancez-le.
3. Le serveur `tradingview-desktop` doit se connecter automatiquement.

## Étape 7 : vérifier la connexion

Utilisez l'outil `tv_health_check`. Réponse attendue :

```json
{
  "success": true,
  "cdp_connected": true,
  "chart_symbol": "...",
  "api_available": true
}
```

Si `cdp_connected` vaut `false`, TradingView n'est pas lancé avec `--remote-debugging-port=9222`.

## Étape 8 : premier brief matinal

L'utilisateur demande : *« Lance morning_brief et donne-moi mon biais de session »*.

Claude scanne la watchlist, lit les indicateurs, applique les critères de `rules.json` et affiche un biais par symbole.

- Pour sauvegarder : *« Sauvegarde ce brief avec session_save »*
- Pour le relire le lendemain : *« Récupère la session d'hier avec session_get »*

## CLI (optionnel)

Pas d'installation globale. Depuis le dossier du projet :

```powershell
node src\cli\index.js status
node src\cli\index.js quote
node src\cli\index.js --help
```

## Dépannage

| Problème | Solution |
|---------|----------|
| `cdp_connected: false` | Lancer TradingView avec `--remote-debugging-port=9222` (étape 5) |
| Le script `.bat` dit que TradingView est déjà ouvert | L'utilisateur enregistre son travail et ferme TradingView, puis relance le script |
| `ECONNREFUSED` | TradingView n'est pas lancé ou le port 9222 est bloqué |
| Serveur MCP absent de Claude Code | `claude mcp list`, puis redémarrer Claude Code |
| `Invalid symbol` / `Invalid timeframe` / `Invalid date` | Utiliser les formats attendus : `NASDAQ:AAPL`, `240`, `D`, `AAAA-MM-JJ` |
| Données obsolètes | TradingView charge encore, attendre quelques secondes |
| Les outils Pine échouent | Ouvrir d'abord l'éditeur Pine (`ui_open_panel` avec `pine-editor` / `open`) |
| `layout_switch` renvoie `waiting_for_user` | TradingView demande quoi faire des modifications non enregistrées : laisser l'utilisateur choisir |

## Sécurité

- Pas de courtier connecté dans TradingView pendant l'utilisation du port 9222.
- Confirmation de l'utilisateur pour les outils qui agissent : Pine (`pine_set_source`, `pine_save`…), alertes, dessins, `layout_switch`, `tv_launch`, `batch_run`, `session_save`.
- Détail des corrections de ce fork : `INSTALL_WINDOWS_SECURISE.md`.

## À lire ensuite

- `rules.json` : les règles de trading personnelles (à remplir avant `morning_brief`)
- `CLAUDE.md` : quel outil utiliser et quand (chargé automatiquement par Claude Code)
- `README.md` : référence complète des 76 outils
- `INSTALL_WINDOWS_SECURISE.md` : procédure sécurisée et liste des corrections
- `RESEARCH.md` : contexte de recherche
