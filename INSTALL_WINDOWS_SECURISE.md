# Installation sécurisée sous Windows

Cette version du fork a été durcie (voir la liste des corrections en bas). Suivez ces étapes dans l'ordre.

## 1. Installer les dépendances

Depuis le dossier du projet :

```powershell
npm ci --ignore-scripts
```

- `npm ci` installe **exactement** les versions de `package-lock.json` (jamais de version plus récente non vérifiée).
- `--ignore-scripts` empêche tout script d'installation de s'exécuter.
- Ne lancez **pas** `npm link` (installation globale inutile).
- Ne lancez **pas** `npm run test:e2e` / `test:all` / `test:verbose` : ces tests pilotent votre TradingView réel et effacent vos dessins.

## 2. Enregistrer le serveur MCP sous un nom distinct

```powershell
claude mcp add tradingview-desktop --scope user -- node C:\chemin\vers\claudeverstradingview\src\server.js
```

Le nom `tradingview-desktop` évite tout conflit avec un autre serveur TradingView déjà configuré.

## 3. Lancer TradingView en mode débogage (uniquement quand vous en avez besoin)

1. Enregistrez votre travail et fermez TradingView.
2. Lancez `scripts\launch_tv_debug.bat` (il refuse de fermer TradingView à votre place).
3. Fermez TradingView quand vous avez fini : le port 9222 se referme avec lui.

## Règles d'usage

- **Ne connectez aucun courtier** dans TradingView Desktop pendant qu'il tourne avec le port 9222.
- Laissez Claude Code demander confirmation pour les outils qui agissent : `ui_open_panel`, `ui_hover`, `ui_scroll`, `alert_*`, `pine_*`, `draw_*`, `layout_switch`, `tv_launch`, `replay_*`, `batch_run`, `session_save`.
- Les outils de lecture (`chart_get_state`, `data_get_*`, `quote_get`, `symbol_info`, `symbol_search`) peuvent être autorisés sans confirmation.

## Corrections de sécurité appliquées dans ce fork

1. Suppression du robot de trading réel `scalper-run.js` et de son journal ; `rules.json` remplacé par l'exemple.
2. Suppression de l'outil `ui_evaluate` (exécution de JavaScript arbitraire), du panneau `trading`, et des outils de clic/saisie libres `ui_click`, `ui_keyboard`, `ui_type_text`, `ui_mouse_click`.
3. Tous les paramètres insérés dans le JavaScript injecté sont validés (`src/validate.js`) et échappés avec `JSON.stringify`.
4. `morning_brief` ne lit plus de chemin fourni par l'appelant ; `session_get`/`session_save` n'acceptent qu'une date `YYYY-MM-DD`.
5. Nom de fichier des captures limité à `[A-Za-z0-9_-]`.
6. `tv_launch` ne ferme plus TradingView par défaut ; les scripts de lancement Windows, macOS et Linux non plus (ils s'arrêtent si TradingView est ouvert).
7. `layout_switch` ne clique plus automatiquement sur « Discard / Don't save ».
8. `.env` et fichiers de clés ajoutés au `.gitignore`.
9. `npm test` ne lance plus les tests qui pilotent TradingView ; procédure d'installation ci-dessus.
