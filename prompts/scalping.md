# Prompt fixe — plan de scalping (v1)

Claude PRÉPARE les niveaux avant la séance ; le déclenchement en 1 min se fait par moi
(ou par un indicateur), pas par Claude, trop lent pour une entrée en 1 min.
À coller dans une NOUVELLE session locale (mode Manuel), 15 min avant la séance visée.

```
=== PLAN DE SCALPING — PROMPT FIXE v1 ===
ACTIF : PEPPERSTONE:XAUUSD        Contexte : 5 min   Déclenchement : 1 min
COMPTE : Pepperstone DEMO, en EUR RISQUE PAR TRADE : ____ € (0,01 lot = 1 $ par point)
SÉANCE VISÉE : ouverture Londres (09:00-11:00 Paris) / ouverture New York (15:30-17:30 Paris)

RÈGLES ABSOLUES
- Mêmes règles que le prompt d'analyse v4 : lecture seule, aucun ordre, aucun tracé sans « go » + numéros, drawings_log.md, pas d'alert_create, heures en UTC ET Paris.
- Tu prépares un PLAN pour la séance. Tu ne donnes pas de signal en direct : le déclenchement 1 min est fait par moi.

1. DONNÉES (lecture seule, sans changer l'unité de temps du graphique)
data_get_ohlcv (max de barres, sans les afficher) : reconstruis le 5 min, le H1 et le H4 à partir des barres disponibles. Si le graphique est en 15 min, dis-le : le 1 min n'est pas lisible sans changer d'unité de temps, donc je le suivrai moi-même.
quote_get, data_get_study_values, data_get_pine_* avec study_filter "LuxAlgo" et "AMD".

2. CONTEXTE
- Biais H1 et H4 (structure du prix), et niveau d'invalidation.
- Annonces US du jour : heure UTC + Paris. Pas de scalping de 15 min avant à 15 min après une annonce ; pas de scalping du tout un jour de CPI/NFP/FOMC avant l'annonce.
- ATR(14) en 5 min et estimation de l'ATR 1 min (≈ ATR 5 min ÷ 2,2).
- Niveaux de la séance : plus haut/plus bas de la veille, ouverture du jour, plus haut/plus bas Asie et, pour NY, plus haut/plus bas Londres.
- Liquidité INTACTE vs BALAYÉE en 5 min (plus hauts/plus bas égaux, sommets/creux de séance).

3. SETUPS AUTORISÉS (2 maximum, un dans chaque sens au plus)
Seul setup autorisé : BALAYAGE + RÉINTÉGRATION sur un niveau de liquidité intacte listé ci-dessus.
- Déclencheur (à faire par moi en 1 min) : la mèche 1 min dépasse le niveau, une bougie 1 min clôture de retour à l'intérieur, puis CHoCH 1 min (cassure du dernier creux/sommet 1 min).
- Entrée : au marché après le CHoCH 1 min, ou sur le retest du niveau.
- Stop : au-delà de la mèche du balayage + 0,3 ATR 1 min + spread ; stop minimum 2,5 points (en dessous, le bruit et le spread le déclenchent).
- TP1 : premier obstacle en 5 min ; TP2 : liquidité suivante. Liste les obstacles.
- R:R ≥ 1,5 au TP1, spread inclus, sinon rejeté. Donne la formule d'entrée maximale selon la profondeur de la mèche.
- Sens : dans le sens du biais H1 de préférence ; contre-tendance noté « CT », uniquement si le TP1 est un obstacle clair et proche.

4. GESTION ET LIMITES (non négociables, à rappeler en fin de réponse)
- Taille : lots = risque ÷ (distance du stop × 100 $), arrondi vers le bas, minimum 0,01.
- 50 % au TP1 puis stop au point d'entrée ; sortie totale si le trade n'a pas atteint TP1 après 15 bougies 1 min.
- Maximum 3 trades par séance. Arrêt de la séance après 2 pertes consécutives ou −2 R cumulés. Pas de nouveau trade pour « se refaire ».
- Stop et TP ACTIVÉS dans le ticket AVANT d'envoyer l'ordre.

5. RÉPONSE
- 3 lignes : biais, niveaux à balayer, fenêtre horaire (UTC / Paris).
- Tableau : N° | Sens | Niveau à balayer | Déclencheur 1 min | Stop (formule) | Entrée max pour 1,5 R | TP1 (obstacle) | TP2 | Invalidation | Valable de … à … | Taille
- Alertes à créer à la main (valeur avec une VIRGULE) : chaque niveau à balayer.
- Si aucun setup : « PAS DE SCALP » et pourquoi.
- Tracés proposés numérotés (une ligne par niveau à balayer, rien d'autre), non exécutés.
```
