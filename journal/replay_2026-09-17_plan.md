# Replay 17/09/2026 — plan figé à 07:15 UTC (09:15 Paris), prompt v4.3 sans AMD

Figé AVANT d'avancer le replay. Dernière bougie connue : 07:00–07:15 UTC (O 4311,01 H 4323,55 B 4309,23 C 4322,82).
Données : 329 bougies 15 min, du 11/09 17:00 au 17/09 07:00 UTC. Indicateurs : LuxAlgo seul (AMD absent).
Choix du jour : le 21/09 était prévu, mais Claude en connaissait déjà le déroulé (vu pendant le test du 24/09). Le 18/09 était un peu touché aussi (17:00–18:00 vus). Le 17/09 est vierge.

## Contexte
- Veille (16/09, séance 15/09 22:00 → 16/09 21:00) : FOMC à 18:00 UTC. PDH 4366,40 (18:00, juste avant la chute) · PDL 4235,44 (19:00) · PDC 4263,87
- Ouverture du jour (16/09 22:00 UTC) : 4262,28
- Asie 17/09 (00-07 UTC) : haut 4318,26 (01:30) · bas 4266,23 (00:00). Plus bas depuis l'ouverture : 4257,47 (22:15).
- Londres 17/09 : la bougie de 07:00 a cassé le haut d'Asie (plus haut 4323,55, clôture 4322,82).
- ATR 15 min ≈ 8 · ATR H1 ≈ 28 (gonflé par la FOMC)
- Annonces US du 17/09 (jeudi) : inscriptions au chômage et Philly Fed à 12:30 UTC (14:30 Paris), probables ; non vérifiables en replay (incertain). Par prudence : pas d'entrée entre 12:00 et 12:45 UTC, position soldée à 12:00 UTC si le TP2 n'est pas atteint (sauf reliquat au point d'entrée).

## Structure
- H4 : range 4253–4366 du 14 au 16/09, puis chute FOMC de 4366,40 à 4235,44 (nouveau plus bas, sous 4253,53 et 4261,5) → BOS baissier. Biais BAISSIER tant que 4366,40 (dernier sommet avant la chute) tient.
- H1 : depuis 4235,44, creux montants 4257,47 → 4266,23 → 4273,83 → 4285,29 → 4304,22, sommets montants 4276,72 → 4286,83 → 4318,26 → 4323,55. HAUSSIER. H4 et H1 en désaccord → setup principal dans le sens du H4 + setup CT dans le sens du H1.
- Extension : +88 pts (≈ 11 ATR 15 min) depuis 4235,44, soit 67 % de la chute FOMC ; +38 pts (≈ 4,7 ATR) depuis 4285,29.
- Sens du jour annoncé : HAUSSIER (H1 vers la liquidité intacte au-dessus : 4323,8–4324,4 puis 4338,9–4341,3). Le biais H4 baissier ne reprend la main qu'après un balayage du PDH.

## Liquidité
- INTACTE au-dessus : hauts égaux 4323,55 / 4323,76 / 4324,41 (bougies FOMC 18:15-18:30 + 07:00) · 4338,88 / 4341,26 (16/09 03:00-03:15) · 4353–4361 (16/09 après-midi) · PDH 4366,40 · 4369,87 / 4370,55 (11/09, ANCIEN)
- INTACTE en dessous : bas égaux 4304,22 / 4304,72 / 4305,69 (06:00-06:30) · 4285,29 (05:15) · 4280,95 / 4273,83 · bas Asie 4266,23 · 4257,47 · PDL 4235,44
- DÉJÀ BALAYÉE : haut Asie 4318,26 (07:00) · 4312,58 · 4315,40 · 4297,61 / 4299,29
- Zones LuxAlgo : demande 4305,69–4312,94 (touchée une fois à 06:45) ; demandes 4285,29–4288,45, 4273,83–4280,96, 4259,01–4265,98, 4257,47–4260,02. Aucune offre active affichée au-dessus.

## Setups (on ne prend que le PREMIER déclenché, jamais deux)
### N°1 VENTE (sens H4, contre le H1) — note A, trade de balayage
- Condition : balayage du PDH 4366,40 (dernière liquidité importante au-dessus), puis réintégration sous 4366,40
- Déclencheur : rejet 15 min avec mèche au-dessus de 4366,40 + clôture sous 4366,40, ET CHoCH 5 min (forte impulsion contre le trade → les deux)
- Stop : plus haut réel de la mèche + 0,3 ATR (2,4) + spread (0,3) = mèche + 2,7 (minimum 4369,1)
- TP1 : 4341,5 (1er obstacle : sommets 16/09 03:15 et creux pré-FOMC 4340,2-4341,7) → sortie 50 %, stop à l'entrée
- TP2 : 4305,9 (bas égaux 4304,22–4305,69)
- Obstacles : 4341,5 · 4334,7 · 4324 · 4318 · 4312,9
- R:R : entrée minimale = max((4305,9 + 1,5 × stop) ÷ 2,5 ; (4341,5 + 0,8 × stop) ÷ 1,8). Ex. mèche 4368 → stop 4370,7 → entrée ≥ 4354,5 ; mèche 4372 → stop 4374,7 → entrée ≥ 4356,3.
- Annulation : TP2 4305,9 atteint après le balayage et avant l'entrée ; bas égaux 4304,22 balayés avant le balayage du PDH.
- Invalidation : clôture 15 min au-dessus de 4370,55
- Taille : 0,01 lot

### N°2 ACHAT CT (sens H1, contre le H4) — note A, retour en zone après balayage
- Condition : balayage des bas égaux 4304,22–4305,69, dans la demande LuxAlgo 4305,69–4312,94
- Déclencheurs CT (les 3) : balayage (mèche sous 4304,22) + clôture 15 min de réintégration au-dessus de 4305,69 avec mèche + CHoCH 5 min haussier
- Stop : plus bas réel de la mèche − 2,7 (maximum 4301,5)
- TP1 : 4323,2 (hauts égaux 4323,55–4324,41) → 50 %, stop à l'entrée
- TP2 : 4338,5 (sommets 4338,88 / 4341,26)
- Obstacles : 4312,9 · 4318,3 · 4323,5–4324,4 · 4334
- R:R : entrée maximale = min((4338,5 + 1,5 × stop) ÷ 2,5 ; (4323,2 + 0,8 × stop) ÷ 1,8). Ex. mèche 4302 → stop 4299,3 → entrée ≤ 4312,6 ; mèche 4298 → stop 4295,3 → entrée ≤ 4310,8.
- Annulation : TP2 4338,5 atteint avant l'entrée.
- Invalidation : clôture 15 min sous 4297,5 (base de la bougie de cassure 05:45)
- Taille : 0,01 lot (CT = taille minimale)

### N°3 ACHAT CT (b) continuation (sens H1) — note A sous condition
- Proposé car la zone du N°2 est à ≈ 2,1 ATR du prix.
- BOS 15 min : clôture de 07:00 (4322,82) au-dessus du haut d'Asie 4318,26.
- Entrée : retest de 4318,26 (ou du FVG laissé par la cassure) avec déclencheur (rejet 15 min avec mèche + clôture au-dessus de 4318,26, ou CHoCH 5 min)
- Stop : plus bas du retest − 2,7, distance minimale 8 (1 ATR)
- TP1 : 4323,2 · TP2 : 4338,5
- R:R : entrée maximale = min(4323,2 − 0,8 × risque ; 4338,5 − 1,5 × risque). Avec le risque minimal de 8 → entrée ≤ 4316,8. Une entrée au-dessus est « déclenchée mais rejetée ».
- Annulation : TP2 4338,5 atteint avant l'entrée. Invalidation : clôture 15 min sous 4312,94.
- Taille : 0,01 lot

- Valable (tous) : 07:15–18:00 UTC (09:15–20:00 Paris), hors 12:00–12:45 UTC

### B (non proposés)
- ACHAT immédiat : juste sous les hauts égaux 4323,55–4324,41 intacts, 4,7 ATR d'extension. Rejeté.
- VENTE sur balayage des hauts égaux 4324,41 : contre le H1 avec le PDH 4366,40 intact au-dessus. Note B.

## Captures d'écran
(à compléter)
