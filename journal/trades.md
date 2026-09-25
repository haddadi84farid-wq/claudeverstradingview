# Journal des trades

Une ligne par SETUP proposé et déclenché, pris ou non (voir journal/protocole_test.md). Résultats réels : onglet « Historique d'ordres » du courtier.
R = résultat ÷ risque initial (distance entrée → stop × taille). Plan respecté : oui / non (+ raison).

| Date | Version prompt | Mode (direct/replay) | Setup pris ? | Plan | Sens | Entrée | Stop | TP | Taille | Sortie | Résultat (€) | R | Plan respecté | Note |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 2026-09-25 | v4 (avant règles liquidité) | direct | oui | Vente 4297-4303 (15 min) | Vente | 4291,20 | 4306,95 | 4257 | 0,06 | 4306,95 | ≈ −83 (−94,5 $) | −1 | oui (plan ajusté : entrée après cassure 5 min au-dessus de 4289), taille 0,06 volontaire | Erreur du plan, pas de l'exécution : vente sous le PDH 4303,44 intact, contre le H1. Sortie au stop (stop noté 4306,8 dans l'ancien trades_local.md) |
| 2026-09-22 | v4 sans AMD | replay | non : déclenché mais rejeté (R:R réel 0,27 < 1,5, TP atteints avant l'entrée) | N°1 Vente A : zone 4340,66-4347,50 (OB 05:00) après balayage de 4343,18 ; rejet 15 min + CHoCH 5 min | Vente | — (déclencheur à 4330,41, clôture 5 min 13:25 UTC) | 4352,2 | TP1 4324,5 / TP2 4315,0 | 0,01 | — | — | 0 (non compté comme trade) | oui (rejet conforme) | Analyse à 07:15 UTC (bougie 07:00-07:15 vue). Sur le papier, le TP1 aurait été touché à 14:25 UTC (+0,27 R). Balayage 12:30 (4344,03), rejet 15 min clôturé 4332,07. TP1/TP2 déjà atteints AVANT l'entrée (EQL 4315 balayée 07:30, plus bas 4291,56 à 08:30) : cibles périmées. R:R réel à l'entrée 0,27 au lieu de 2,4 prévu depuis le milieu de zone. Stop jamais menacé (max 4344,15) avant 17:45. |
| 2026-09-23 | v4.1 sans AMD | replay | non : pas déclenché | N°1 Vente A : zone 4340,25-4347,32 après balayage de 4337,21 ; rejet 15 min + CHoCH 5 min ; entrée réelle ≥ 4343,2 (plan : journal/replay_2026-09-23_plan.md) | Vente | — | 4349,4 | TP1 4333,1 / TP2 4314,85 | 0,01 | — | — | 0 (non compté) | oui | Analyse à 07:15 UTC. Aucun retracement : plus haut après 07:15 = 4328,67 (07:15), 4337,21 jamais balayé. Le marché a continué à baisser sans pullback : 4314,85 pris à 09:30, PDL 4291,56 balayé à 13:30, plus bas 4274,82 à 17:30. Setup bon sur le sens, mais il exigeait un retracement de 2,7 ATR qui n'est pas venu. |
| 2026-09-24 | v4.2 sans AMD | replay | non : annulé (TP2 pris avant le balayage) | N°1 Vente A (balayage) : balayage des hauts égaux 4296,40/4297,21 puis réintégration dans l'offre 4289,34-4296,40 ; rejet 15 min + CHoCH 5 min (plan : journal/replay_2026-09-24_plan.md) | Vente | — | mèche + 2,5 | TP1 4281,5 / TP2 4274,0 | 0,01 | — | — | 0 (non compté) | oui | Analyse à 07:30 UTC (et non 07:15 : le replay a avancé d'une bougie de trop). 4297,21 jamais balayé (max 4288,07). Bas égaux 4273,62 balayés à 08:15, plus bas 4243,90 à 10:30, clôture 17:45 à 4264,78. Sens juste (−30 pts sous la cible), 3e jour sans trade. Continuation (b) non proposée faute de liquidité connue sous 4273,62 ; sur le papier elle aurait fait au mieux +1,2 R sans toucher un TP1 à 1,5 R. |

## Statistiques (à recalculer par Claude sur demande)
- Nombre de trades : 1
- Taux de réussite : 0 % (0 gagnant)
- Gain moyen (R) / perte moyenne (R) : — / −1,0
- Espérance par trade (R) : −1,0
- Trades hors plan : 0
- (Les chiffres ci-dessus = mode direct uniquement.)

### Replay (séparé du direct)
- v4 sans AMD : 1 setup déclenché puis rejeté (R:R réel < 1,5, TP atteints avant l'entrée), 0 trade compté.
- v4.1 sans AMD : 1 jour testé (23/09), 1 setup proposé, 0 déclenché, 0 trade compté. Échantillon 0/30.
- v4.2 sans AMD (ajout du setup de continuation) : 1 jour testé (24/09), 1 setup proposé, 0 déclenché (annulé), 0 trade compté. Échantillon 0/30.
- v4.3 sans AMD (R:R ≥ 1,5 au TP2 et ≥ 0,8 au TP1 ; continuation avec mouvement mesuré et stop au retest) : 0 jour testé. Échantillon 0/30.
- Sens du jour juste (toutes versions) : 3/3 (22, 23 et 24/09).

## Leçons
- 2026-09-25 : une liquidité intacte (PDH 4303,44) vers laquelle va le H1 est un aimant. Ne pas vendre sous elle tant qu'elle n'est pas prise.
- 2026-09-22 (replay) : le plan n'avait pas de règle d'annulation quand la liquidité cible (TP2) est prise AVANT l'entrée. Le setup s'est déclenché 5 h plus tard avec des cibles périmées et un R:R réel de 0,27. Le R:R n'est vérifié qu'au moment de l'analyse, pas au déclencheur. → Corrigé en v4.1 : R:R recalculé au déclenchement, setup annulé si le TP1 est atteint avant l'entrée.
- 2026-09-23 (replay) : sens juste (baisse de plus de 50 points vers le PDL), mais aucun setup déclenché : le seul type d'entrée attendait un retour lointain (≈ 2,7 ATR) dans une zone. → v4.2 : ajout du setup de continuation (BOS 15 min + retest, vers la liquidité intacte).
- 2026-09-24 (replay, v4.2) : sens juste pour le 3e jour de suite, mais toujours aucun trade. L'aimant (bas égaux 4273,62) a été pris dès 08:15 sans le retracement attendu. La continuation (b) n'a pas pu être proposée car aucune liquidité n'était connue sous l'aimant (fin de la fenêtre de données) ; et avec le stop exigé au-dessus du dernier sommet avant la cassure (risque ≈ 20 pts, ≈ 2,8 ATR), elle n'aurait pas atteint 1,5 R. Piste à discuter (pas de changement de version sans décision) : objectif quand aucune liquidité n'est connue, et stop de continuation plus serré.
- → v4.3 : R:R minimum calculé au TP2 (objectif principal), TP1 = sortie partielle + stop au point d'entrée ; continuation sans liquidité connue = mouvement mesuré, stop derrière le retest.
- 2026-09-25 : non testable en replay (journée tradée en direct, suite connue).
