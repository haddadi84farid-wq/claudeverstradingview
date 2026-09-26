# Replay 17/09/2026 — plan figé à 22:00 UTC le 16/09 (00:00 Paris le 17/09)

Figé AVANT d'avancer le replay. Dernière bougie connue : 16/09 20:55 UTC (5 min), clôture 4263,87.
Données : 500 bougies 5 min, du 15/09 02:20 au 16/09 20:55 UTC. Indicateurs : LuxAlgo + « Plan XAUUSD — checklist vente » (AMD absent).

ATTENTION, simulation biaisée : le fichier `replay_2026-09-17_plan.md` (plan de 07:15 UTC), lu en début de session,
donne déjà l'Asie du 17/09 (haut 4318,26, bas 4266,23) et la cassure de 07:00 (4323,55). Claude connaît donc la suite jusqu'à 07:15 UTC.

## Contexte
- Veille (16/09) : FOMC 18:00 UTC. PDH 4366,40 · PDL 4235,44 · PDC 4263,87
- ATR 15 min 25,2 · ATR H1 26,0 (gonflés par la FOMC, baisseront en Asie)
- Jeudi 17/09 : inscriptions au chômage + Philly Fed probables à 12:30 UTC (14:30 Paris), incertain → pas d'entrée 12:00–12:45 UTC, flat à 12:00 UTC.

## Structure
- H4 : range 4261–4366 (15–16/09) puis chute FOMC 4366,40 → 4235,44, sous les creux du 15/09 (4261,51) → BOS baissier. Biais BAISSIER tant que 4366,40 tient.
- H1 : baissier depuis la FOMC ; sommet descendant 4287,23 (19:00), puis 4276,72 (19:45 en 15 min), creux 4257,20 (20:15). H4 et H1 d'accord → pas de setup CT obligatoire.
- Extension : −131 pts (≈ 5 ATR H1) depuis 4366,40 ; prix à +28 pts du PDL.

## Liquidité
- INTACTE au-dessus : 4276,72 · 4287,23 · 4307,68 (bougie 18:45) · hauts égaux 4323,76 / 4324,41 (18:15–18:30) · PDH 4366,40
- INTACTE en dessous : 4257,20 · 4239,43 · PDL 4235,44
- DÉJÀ BALAYÉE : tous les sommets du 16/09 sous 4366,40 (4341,26, 4353,58, 4360,52, 4361,61) · creux du 15/09 4261,51 / 4263,72 · 4275,46
- LuxAlgo : seulement des offres au-dessus du PDH (4365,39–4370,55, 4370,58–4377,11, …), ANCIENNES / hors de portée. Aucune demande affichée.

## Setups (fenêtre 07:00–18:00 UTC, hors 12:00–12:45)
### N°1 VENTE (sens H4 + H1) — note A, balayage
- Condition : balayage de 4287,23, entrée dans la zone 4287,2–4301,5 (base de la dernière jambe FOMC, bougie 18:45)
- Déclencheur : rejet 15 min avec mèche au-dessus de 4287,23 + clôture sous, ou CHoCH 5 min (les deux si l'impulsion de montée est forte)
- Stop : plus haut réel de la mèche + 0,3 ATR 15 min + 0,3 spread (avec ATR 25 : mèche + 7,9)
- TP1 : 4276,7 (1er obstacle, sommet 19:45) → 50 %, stop à l'entrée · TP2 : 4257,4 (creux 4257,20)
- R:R (convention v4.3 : ≥ 0,8 R au TP1, ≥ 1,5 R au TP2) : entrée minimale = max((4257,4 + 1,5 × stop) ÷ 2,5 ; (4276,7 + 0,8 × stop) ÷ 1,8). Ex. mèche 4292 → stop 4299,9 → entrée ≥ 4284,0.
- Annulation : 4257,20 balayé avant l'entrée. Invalidation : clôture 15 min au-dessus de 4307,7.
- Taille : 0,01 lot

### B (non proposés)
- ACHAT CT sur balayage du PDL 4235,44 : contre H4 et H1, cible 4257–4276 seulement.
- VENTE continuation sous 4257,20 : seulement 20 pts jusqu'au PDL, R:R insuffisant.

## Bilan
Replay avancé jusqu'au 17/09 20:45 UTC (dernière bougie 15 min, clôture 4341,59).
- N°1 : 4287,23 balayé à 00:30 UTC (02:30 Paris, plus haut 4292,15), en ASIE, hors fenêtre. Puis clôture 15 min de 01:15 UTC à 4310,14 > 4307,7 → INVALIDÉ avant 07:00 UTC. Aucun trade.
- Journée : haussière. Haut d'Asie 4318,26 cassé à 07:00 UTC, PDH 4366,40 balayé à 12:15 UTC (plus haut 4381,39, clôture 4381,02), en pleine fenêtre d'annonce. Range 4351–4380 l'après-midi, clôture 20:45 UTC à 4341,59.
- Leçon : le biais H4 baissier post-FOMC a été contredit dès l'Asie ; le plan de minuit n'avait pas de scénario haussier (pas de CT car H4 et H1 étaient alors d'accord).
