# Replay 24/09/2026 — plan figé à 07:30 UTC (09:30 Paris), prompt v4.2 sans AMD

Figé AVANT d'avancer le replay. Dernière bougie connue : 07:15–07:30 UTC (O 4284,13 H 4288,12 B 4281,03 C 4284,91).
Écart au protocole : analyse prévue à 07:15, mais le replay a avancé d'une bougie de trop (bougie 07:15 visible). Pour ne rien utiliser de postérieur, le plan est figé à 07:30.
Données : 330 bougies 15 min, du 18/09 17:00 au 24/09 07:15 UTC. Indicateurs : LuxAlgo seul (AMD absent).

## Contexte
- Veille (23/09, séance 22/09 22:00 → 23/09 21:00) : PDH 4369,52 (00:00) · PDL 4274,82 (17:30) · PDC 4287,55
- Ouverture du jour (22:00 UTC) : 4290,59
- Asie 24/09 (00-07 UTC) : haut 4303,44 (01:15) · bas 4273,62 (02:00, a balayé le PDL 4274,82)
- Londres 24/09 jusqu'ici : haut 4288,12 (07:15) · bas 4274,29 (07:00)
- ATR 15 min ≈ 7,2 · ATR H1 ≈ 15,0
- Annonces US du 24/09 (jeudi) : inscriptions au chômage 12:30 UTC (14:30 Paris), probable ; autres publications non vérifiables en replay (incertain). Par prudence : pas d'entrée entre 12:00 et 12:45 UTC, position soldée à 12:00 UTC si le TP2 n'est pas atteint.

## Structure
- H4 : sommets descendants 4376,11 → 4371,25 → 4369,52 → 4347,32 → 4318,92 → 4303,44 ; creux 4291,56 → 4274,82 → 4273,62 (creux plats). Biais BAISSIER tant que 4303,44 tient (puis 4318,92).
- H1 : range descendant depuis le 23/09 13:00 : sommets 4303,44 → 4297,21 → 4296,40 → 4288,12 ; creux 4274,82 / 4273,62 / 4277,49 / 4274,29 (bas égaux). BAISSIER (sommets descendants). H4 et H1 alignés, donc pas de setup CT obligatoire.
- Extension : 29 pts (≈ 4 ATR) de 4303,44 à 4274,29, puis rebond de 10 pts. Prix au milieu du range 4274–4297 → entrée immédiate rejetée.

## Liquidité
- INTACTE en dessous : bas égaux 4273,62 / 4274,29 / 4274,31 (AIMANT, dans le sens du H1). Rien de connu plus bas dans la fenêtre de données.
- INTACTE au-dessus : 4288,12 (haut 07:15) · hauts égaux 4296,40 / 4297,21 · 4303,44 (haut Asie, dernier sommet descendant) · 4318,92 / 4319,17
- DÉJÀ BALAYÉE : PDL 4274,82 (02:00) · 4283,74 · 4280,41 · 4277,49 · 4293,37 / 4294,68 / 4294,95 (hauts du 23/09 soir, pris à 01:00)
- Zones LuxAlgo : offre 4289,34–4296,40 (OB 05:00, non testée) ; offre 4295,52–4303,44 (OB 01:15, déjà testée 2 fois : 02:30 et 05:00 → faible) ; 4309,03–4318,92 et 4314,52–4319,17 ; 4344,52–4347,32 (loin)

## Setups
### N°1 VENTE — note A (trade de balayage, retour en zone)
- Condition : balayage des hauts égaux 4296,40 / 4297,21 (plus haut ≥ 4297,3), puis réintégration dans l'offre 4289,34–4296,40
- Déclencheur : rejet 15 min avec mèche au-dessus de 4297,21 + clôture sous 4296,40, ET CHoCH 5 min (clôture sous le dernier creux 5 min). Les deux sont exigés (rebond de ≈ 3 ATR contre le trade si le balayage a lieu).
- Stop (exception balayage) : plus haut réel de la mèche + 0,3 ATR (2,2) + spread (0,3) = mèche + 2,5. Plafond : si la mèche dépasse 4303,44, invalidation (voir ci-dessous).
- TP1 : 4281,5 (1er obstacle : creux 4281,03 / 4280,41)
- TP2 : 4274,0 (bas égaux 4273,62–4274,31, liquidité principale)
- Obstacles : 4285,1 (clôtures 03:45-04:15) · 4281,0 / 4280,4 · 4277,5 · 4274,3
- R:R : entrée minimale pour 1,5 R au TP1 = (4281,5 + 1,5 × stop) ÷ 2,5. Exemples : mèche 4298 → stop 4300,5 → entrée ≥ 4292,9 ; mèche 4300 → stop 4302,5 → entrée ≥ 4293,9 ; mèche 4303 → stop 4305,5 → entrée ≥ 4295,9. Recalculé au déclenchement avec l'entrée réelle ; sous 1,5 → « déclenché mais rejeté ».
- Annulation : si les bas égaux 4273,62 sont balayés avant le balayage de 4297,21 (cible prise) ; si le TP1 4281,5 est touché après le balayage et avant l'entrée.
- Invalidation : clôture 15 min au-dessus de 4303,44
- Valable : 07:30–18:00 UTC (09:30–20:00 Paris), hors 12:00–12:45 UTC
- Taille : 0,01 lot, sortie totale au TP1

### B (non proposés)
- VENTE dans l'offre 4295,52–4303,44 : zone déjà testée 2 fois. Note B.
- CONTINUATION (b) sous 4273,62 : pas de liquidité connue plus bas dans la fenêtre de données, donc pas d'objectif. Non proposé.
- ACHAT CT après balayage des bas égaux 4273,62 : H4 et H1 alignés baissiers, pas de liquidité connue sous le stop. Note B.

## Résultat (écrit après l'avance jusqu'à 18:00 UTC)
- N°1 VENTE : ANNULÉ à 08:15 UTC. Les bas égaux 4273,62 (TP2) ont été balayés (plus bas 4262,45) avant tout balayage de 4297,21. Plus haut après 07:30 : 4287,89 (07:30) puis 4288,07 (16:15) ; 4297,21 jamais atteint. 0 trade.
- Déroulé : cassure 15 min sous 4273,62 à 08:15 (clôture 4264,61), retest du niveau cassé à 08:30 (haut 4273,71, clôture 4268,11), puis baisse jusqu'à 4243,90 à 10:30. Rebond à 4283,27 (12:45), nouveau plus bas 4244,65 à 15:00, pic à 4288,07 à 16:15 (après l'annonce probable), clôture 17:45 à 4264,78.
- Sur le papier, une continuation (b) sur le retest de 08:30 (entrée ≈ 4268,1, stop au-dessus du dernier sommet avant la cassure 4285,67 + 2,5 = 4288,2, risque ≈ 20) n'aurait pas atteint 1,5 R (TP1 à 4238) : meilleur point 4243,90 = +1,2 R, puis retour au-dessus de l'entrée à 12:45. Elle n'était de toute façon pas proposée (pas d'objectif connu sous 4273,62).
