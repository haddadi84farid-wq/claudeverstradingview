# Replay 23/09/2026 — plan figé à 07:15 UTC (09:15 Paris), prompt v4.1 sans AMD

Figé AVANT d'avancer le replay. Dernière bougie connue : 07:00–07:15 UTC (O 4331,22 H 4332,94 B 4324,50 C 4324,86).
Données : 329 bougies 15 min, du 17/09 17:00 au 23/09 07:00 UTC. Indicateurs : LuxAlgo seul (AMD absent).

## Contexte
- Veille (22/09, séance 21/09 22:00 → 22/09 21:00) : PDH 4376,11 (00:00) · PDL 4291,56 (08:30) · PDC 4358,60
- Ouverture du jour (22:00 UTC) : 4360,55
- Asie 23/09 (00-07 UTC) : haut 4369,52 (00:00) · bas 4325,93 (06:15), déjà balayé par la bougie de 07:00 (4324,50)
- ATR 15 min ≈ 5,8 (séance asiatique calme) · ATR H1 ≈ 14
- Annonces US du 23/09 : non vérifiables en replay (incertain)

## Structure
- H4 : sommets descendants 4399,75 → 4396,91 → 4383,56 → 4376,11 → 4371,25 ; creux 4291,56 puis 4314,85 (plus bas ascendant). Biais BAISSIER tant que 4371,25 tient.
- H1 : 4371,25 → 4369,52 → 4347,32 (sommet descendant) ; creux 4333,09 → 4324,50. BAISSIER. H4 et H1 alignés, donc pas de setup CT obligatoire.
- Extension : 45 pts (≈ 7,8 ATR) depuis 4369,52 → continuation immédiate rejetée.

## Liquidité
- INTACTE en dessous : 4314,85 / 4314,17 / 4312,09 (creux du 22/09) · 4308,89 · PDL 4291,56
- INTACTE au-dessus : 4337,21 (haut 06:45) · 4347,32 (haut 04:15, sommet descendant H1) · 4369,52 · 4371,25 · PDH 4376,11
- DÉJÀ BALAYÉE : bas Asie 4325,93, 4333,09-4333,67 (bas 02:30-03:00 cassés à 05:30)
- Zones LuxAlgo : offre 4344,52–4347,32 (04:15, non testée) ; demandes 4322,61–4332,53 (prix dedans), 4308,89–4323,46, 4298,19–4307,58

## Setups
### N°1 VENTE — note A
- Zone : 4340,25–4347,32 (bougie 05:15 + OB LuxAlgo 04:15), milieu 4343,8
- Condition : balayage de 4337,21 (haut 06:45), puis entrée dans la zone
- Déclencheur : rejet 15 min avec mèche + clôture sous 4337,21, ET CHoCH 5 min (clôture). Les deux sont exigés à cause du retracement de ≈ 2,7 ATR contre le trade.
- Stop : 4349,4 (au-delà du sommet descendant H1 4347,32, + 0,3 ATR + spread)
- TP1 : 4333,1 (1er obstacle, bas asiatiques) = 1,9 R depuis le milieu de zone
- TP2 : 4314,85 (liquidité, creux du 22/09) = 5,2 R
- Obstacles : 4333,1 · 4325,9/4324,5 · demande 4322,6–4332,5 · 4314,85
- Règles v4.1 :
  - Au déclenchement, entrée réelle ≥ 4343,2 obligatoire (R:R ≥ 1,5 au TP1, spread inclus). Sinon « déclenché mais rejeté ».
  - Annulation si le prix revient à 4333,1 (TP1) après avoir balayé 4337,21 et avant l'entrée. Au moment de l'analyse, le prix est déjà sous le TP1 ; le setup n'est « armé » qu'au balayage de 4337,21.
- Invalidation : clôture 15 min au-dessus de 4347,32
- Valable : 07:15–18:00 UTC (09:15–20:00 Paris)
- Taille : 0,01 lot (risque ≈ 5,6 $), sortie totale au TP1

### B (non proposé)
- ACHAT CT dans la demande 4308,89–4323,46 après balayage de 4314,85 : contre H1 et H4, avec le PDL 4291,56 intact sous le stop. Note B.
- VENTE immédiate : rejetée (extension 7,8 ATR, prix dans une zone de demande).
