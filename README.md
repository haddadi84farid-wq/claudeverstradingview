
# Claude vs TradingView — fork durci

**Claude vs TradingView** connecte Claude Code à TradingView Desktop via le Chrome DevTools Protocol (CDP). Il vous donne un brief de trading structuré chaque matin, et laisse Claude lire et piloter vos graphiques.

Ce fork (`haddadi84farid-wq/claudeverstradingview`) est une **version durcie** du projet d'origine. Les fonctions dangereuses ont été retirées et toutes les entrées sont validées. Voir [Sécurité](#sécurité) et `INSTALL_WINDOWS_SECURISE.md`.

---

## Prérequis

- Application desktop TradingView (abonnement payant requis pour les données en temps réel)
- Node.js 18+
- Claude Code
- Windows (procédure détaillée ci-dessous). macOS et Linux fonctionnent aussi, voir la remarque dans « Lancer TradingView ».

---

## Installation (Windows)

### 1. Récupérer le code

Avec Git :

```powershell
git clone https://github.com/haddadi84farid-wq/claudeverstradingview.git $HOME\claudeverstradingview
cd $HOME\claudeverstradingview
```

Sans Git : téléchargez le ZIP depuis la page GitHub du fork (bouton **Code → Download ZIP**) et décompressez-le dans `C:\Users\<vous>\claudeverstradingview`.

### 2. Installer les dépendances

```powershell
npm ci --ignore-scripts
```

- `npm ci` installe **exactement** les versions verrouillées dans `package-lock.json`.
- `--ignore-scripts` empêche tout script d'installation de s'exécuter.
- `npm link` n'est **pas** nécessaire : la CLI se lance avec `node src\cli\index.js` (voir [CLI](#cli)).

### 3. Configurer vos règles

`rules.json` contient un exemple neutre. Ouvrez-le et renseignez votre watchlist, vos critères de biais et vos règles de risque.

Les symboles doivent être au format TradingView (`BTCUSD`, `NASDAQ:AAPL`, `OANDA:XAUUSD`, `NYMEX:CL1!`) et le timeframe au format `1`, `15`, `60`, `240`, `D`, `W`…

### 4. Ajouter le serveur à Claude Code

```powershell
claude mcp add tradingview-desktop --scope user -- node $HOME\claudeverstradingview\src\server.js
```

Le nom `tradingview-desktop` évite tout conflit avec un autre serveur TradingView déjà configuré. Redémarrez Claude Code ensuite, puis vérifiez avec `claude mcp list`.

### 5. Lancer TradingView avec CDP

1. Enregistrez votre travail et **fermez TradingView**.
2. Lancez :

   ```bat
   scripts\launch_tv_debug.bat
   ```

   Le script refuse de démarrer si TradingView est déjà ouvert : il ne le ferme jamais à votre place.
3. Fermez TradingView quand vous avez fini : le port 9222 se referme avec lui.

> **macOS / Linux :** utilisez `./scripts/launch_tv_debug_mac.sh` ou `./scripts/launch_tv_debug_linux.sh`. Comme le script Windows, ils refusent de démarrer si TradingView est déjà ouvert et ne le ferment jamais à votre place.

### 6. Vérifier

Dans Claude Code : *« Utilise tv_health_check pour vérifier que TradingView est connecté »*.

---

## Workflow du brief matinal

1. TradingView est ouvert, lancé avec le script ci-dessus.
2. Demandez à Claude : *« Lance morning_brief et donne-moi mon biais de session »*.
3. Claude analyse votre watchlist et affiche par exemple :

```
XAUUSD  | BIAIS: Baissier  | NIVEAU CLE: 3 280  | SURVEILLER: Résistance Order Block 4H
XAGUSD  | BIAIS: Neutre    | NIVEAU CLE: 32,50  | SURVEILLER: Structure en ranging
BTCUSD  | BIAIS: Haussier  | NIVEAU CLE: 83 000 | SURVEILLER: Tenir au-dessus du OB daily

Global : Prudence sur les métaux. BTC le plus solide des trois.
```

4. Sauvegardez : *« Sauvegarde ce brief »* (`session_save`).
5. Le lendemain, comparez : *« Montre-moi la session d'hier »* (`session_get`).

`morning_brief` change temporairement le symbole et le timeframe du graphique actif pour scanner la watchlist, puis restaure l'état d'origine.

---

## Référence des outils (76 outils MCP)

### Brief matinal

| Outil | Ce qu'il fait |
|---|---|
| `morning_brief` | Scanne la watchlist, lit les indicateurs et retourne les données de biais. Lit `rules.json` à la racine du projet ou `~/.kasper/rules.json`, et nulle part ailleurs. |
| `session_save` | Sauvegarde le brief dans `~/.kasper/sessions/AAAA-MM-JJ.json` |
| `session_get` | Récupère le brief du jour (ou d'hier). La date doit être au format `AAAA-MM-JJ`. |

### Lecture (sans effet sur TradingView)

| Outil | Ce qu'il fait |
|---|---|
| `chart_get_state` | Symbole, timeframe, type, indicateurs et leurs IDs. À appeler en premier. |
| `data_get_study_values` | Valeurs actuelles de tous les indicateurs visibles |
| `quote_get` | Dernier prix, OHLC, volume |
| `data_get_ohlcv` | Bougies (max. 500). `summary: true` pour des stats compactes |
| `data_get_indicator` | Paramètres d'un indicateur |
| `data_get_strategy_results` / `data_get_trades` / `data_get_equity` | Résultats du testeur de stratégie |
| `data_get_pine_lines` / `_labels` / `_tables` / `_boxes` | Niveaux, labels, tableaux et zones dessinés par vos indicateurs Pine |
| `depth_get` | Carnet d'ordres (si le panneau DOM est ouvert) |
| `chart_get_visible_range`, `symbol_info`, `symbol_search` | Plage visible, métadonnées du symbole, recherche |
| `pine_get_source`, `pine_get_errors`, `pine_get_console`, `pine_list_scripts`, `pine_analyze` | Lecture et analyse Pine |
| `alert_list`, `draw_list`, `draw_get_properties`, `watchlist_get`, `layout_list`, `pane_list`, `tab_list` | Listes |
| `tv_health_check`, `tv_discover`, `tv_ui_state`, `replay_status` | État de la connexion et de l'interface |
| `ui_find_element` | Localise des éléments de l'interface (sans cliquer) |

### Actions (modifient votre graphique ou votre compte — confirmation recommandée)

| Outil | Ce qu'il fait |
|---|---|
| `chart_set_symbol`, `chart_set_timeframe`, `chart_set_type`, `chart_scroll_to_date`, `chart_set_visible_range` | Changer l'affichage du graphique |
| `chart_manage_indicator`, `indicator_set_inputs`, `indicator_toggle_visibility` | Ajouter, supprimer ou régler des indicateurs |
| `pine_set_source`, `pine_compile`, `pine_smart_compile`, `pine_save`, `pine_new`, `pine_open` | Éditer, compiler et **enregistrer** des scripts Pine dans votre compte |
| `pine_check` | Envoie votre code Pine au compilateur de TradingView pour vérification |
| `draw_shape`, `draw_remove_one`, `draw_clear` | Dessins (`draw_clear` efface **tous** les dessins) |
| `alert_create`, `alert_delete` | Crée de **vraies** alertes / ouvre le menu de suppression |
| `watchlist_add` | Ajoute un symbole à la watchlist |
| `replay_start`, `replay_step`, `replay_autoplay`, `replay_trade`, `replay_stop` | Mode replay (transactions **fictives** uniquement) |
| `batch_run` | Parcourt plusieurs symboles/timeframes (captures, OHLCV, résultats de stratégie) |
| `capture_screenshot` | Capture dans `screenshots/` (nom de fichier : lettres, chiffres, `-`, `_`) |
| `pane_set_layout`, `pane_focus`, `pane_set_symbol` | Grille multi-graphiques |
| `tab_new`, `tab_close`, `tab_switch` | Onglets |
| `ui_open_panel` | Ouvre ou ferme Pine, le testeur de stratégie, la watchlist ou les alertes (**pas** le panneau de trading) |
| `ui_hover`, `ui_scroll`, `ui_fullscreen` | Survol, défilement, plein écran |
| `layout_switch` | Charge une disposition enregistrée. Si TradingView demande quoi faire des modifications non enregistrées, c'est vous qui choisissez. |
| `tv_launch` | Lance TradingView avec CDP. Ne ferme **jamais** TradingView, sauf si `kill_existing: true` est demandé explicitement. |

### Outils retirés dans ce fork

`ui_evaluate` (JavaScript arbitraire), `ui_click`, `ui_keyboard`, `ui_type_text`, `ui_mouse_click` (clic et saisie libres n'importe où) et le panneau `trading` de `ui_open_panel`.

---

## CLI

Sans installation globale, depuis le dossier du projet :

```powershell
node src\cli\index.js brief                  # brief matinal
node src\cli\index.js session get            # brief du jour sauvegardé
node src\cli\index.js status                 # vérifier la connexion
node src\cli\index.js quote                  # prix actuel
node src\cli\index.js symbol BTCUSD          # changer de symbole
node src\cli\index.js screenshot -r chart    # capturer le graphique
node src\cli\index.js pane layout 2x2        # grille 4 graphiques
```

Aide complète : `node src\cli\index.js --help`.

---

## Tests

- `npm test` : tests hors TradingView (analyse Pine et CLI). `pine_check` y contacte le compilateur Pine de TradingView.
- `npm run test:e2e`, `test:all`, `test:verbose` : **pilotent votre TradingView réel et effacent vos dessins.** Ne les lancez que sur une installation de test.

---

## Dépannage

| Problème | Solution |
|---|---|
| `cdp_connected: false` | TradingView n'est pas lancé avec `--remote-debugging-port=9222`. Utilisez `scripts\launch_tv_debug.bat`. |
| Le script `.bat` dit que TradingView est déjà ouvert | Enregistrez votre travail, fermez TradingView, relancez le script. |
| `ECONNREFUSED` | TradingView non lancé ou port 9222 bloqué |
| Serveur absent de Claude Code | `claude mcp list`, puis redémarrez Claude Code |
| `Invalid symbol` / `Invalid timeframe` | Utilisez le format TradingView (`OANDA:XAUUSD`, `240`, `D`…). Les symboles de spread (`A/B`) ou avec espaces ne sont pas acceptés. |
| « No rules.json found » | Remettez un `rules.json` à la racine du projet (copiez `rules.example.json`) |
| `layout_switch` renvoie `waiting_for_user` | TradingView affiche une fenêtre « modifications non enregistrées » : choisissez vous-même. |
| Données obsolètes | TradingView charge encore, attendez quelques secondes |

---

## Architecture

```
Claude Code  <->  Serveur MCP (stdio)  <->  CDP (localhost:9222)  <->  TradingView Desktop (Electron)
```

- 76 outils MCP
- Pilotage local via le Chrome DevTools Protocol sur `localhost:9222`
- Appels réseau : uniquement vers TradingView (`pine-facade.tradingview.com`, `pricealerts.tradingview.com`, `symbol-search.tradingview.com`). Aucun autre serveur n'est contacté.

---

## Sécurité

- **Ne connectez aucun courtier** dans TradingView Desktop pendant qu'il tourne avec le port 9222.
- Tant que le port 9222 est ouvert, n'importe quel programme de votre PC peut contrôler TradingView : ne l'ouvrez que pendant l'utilisation.
- Laissez Claude Code demander confirmation pour les outils d'action (tableau ci-dessus). N'autorisez sans confirmation que les outils de lecture.
- Les textes affichés sur vos graphiques (labels, tableaux Pine) sont lus par Claude : un contenu malveillant pourrait tenter de l'influencer. Les confirmations limitent ce risque.
- Détail des corrections appliquées : `INSTALL_WINDOWS_SECURISE.md`.

---

## Avertissement

Outil non officiel, non affilié à TradingView Inc. ni à Anthropic. Fourni à des fins personnelles, éducatives et de recherche uniquement. Utilisation à vos propres risques ; respectez les conditions d'utilisation de TradingView.
