# Journal des trades

Une ligne par SETUP proposé et déclenché, pris ou non (voir journal/protocole_test.md). Résultats réels : onglet « Historique d'ordres » du courtier.
R = résultat ÷ risque initial (distance entrée → stop × taille). Plan respecté : oui / non (+ raison).

| Date | Version prompt | Mode (direct/replay) | Setup pris ? | Plan | Sens | Entrée | Stop | TP | Taille | Sortie | Résultat (€) | R | Plan respecté | Note |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 2026-09-25 | v4 (avant règles liquidité) | direct | oui | Vente 4297-4303 (15 min) | Vente | 4291,20 | 4306,95 | 4257 | 0,06 | 4306,95 | ≈ −83 (−94,5 $) | −1 | oui (plan ajusté : entrée après cassure 5 min au-dessus de 4289), taille 0,06 volontaire | Erreur du plan, pas de l'exécution : vente sous le PDH 4303,44 intact, contre le H1. Sortie au stop (stop noté 4306,8 dans l'ancien trades_local.md) |
| 2026-09-22 | v4 sans AMD | replay | non : déclenché mais rejeté (R:R réel 0,27 < 1,5, TP atteints avant l'entrée) | N°1 Vente A : zone 4340,66-4347,50 (OB 05:00) après balayage de 4343,18 ; rejet 15 min + CHoCH 5 min | Vente | — (déclencheur à 4330,41, clôture 5 min 13:25 UTC) | 4352,2 | TP1 4324,5 / TP2 4315,0 | 0,01 | — | — | 0 (non compté comme trade) | oui (rejet conforme) | Analyse à 07:15 UTC (bougie 07:00-07:15 vue). Sur le papier, le TP1 aurait été touché à 14:25 UTC (+0,27 R). Balayage 12:30 (4344,03), rejet 15 min clôturé 4332,07. TP1/TP2 déjà atteints AVANT l'entrée (EQL 4315 balayée 07:30, plus bas 4291,56 à 08:30) : cibles périmées. R:R réel à l'entrée 0,27 au lieu de 2,4 prévu depuis le milieu de zone. Stop jamais menacé (max 4344,15) avant 17:45. |

## Statistiques (à recalculer par Claude sur demande)
- Nombre de trades : 1
- Taux de réussite : 0 % (0 gagnant)
- Gain moyen (R) / perte moyenne (R) : — / −1,0
- Espérance par trade (R) : −1,0
- Trades hors plan : 0
- (Les chiffres ci-dessus = mode direct uniquement.)

### Replay (séparé du direct)
- v4 sans AMD : 1 setup déclenché puis rejeté (R:R réel < 1,5, TP atteints avant l'entrée), 0 trade compté.
- v4.1 : compteurs à zéro (nouvelle version du prompt).

## Leçons
- 2026-09-25 : une liquidité intacte (PDH 4303,44) vers laquelle va le H1 est un aimant. Ne pas vendre sous elle tant qu'elle n'est pas prise.
- 2026-09-22 (replay) : le plan n'avait pas de règle d'annulation quand la liquidité cible (TP2) est prise AVANT l'entrée. Le setup s'est déclenché 5 h plus tard avec des cibles périmées et un R:R réel de 0,27. Le R:R n'est vérifié qu'au moment de l'analyse, pas au déclencheur. → Corrigé en v4.1 : R:R recalculé au déclenchement, setup annulé si le TP1 est atteint avant l'entrée.
