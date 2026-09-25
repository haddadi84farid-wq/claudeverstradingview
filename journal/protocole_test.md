# Protocole de test des analyses de Claude (compte démo)

But : savoir, chiffres à l'appui, si les setups proposés par Claude ont une espérance positive.

## Règles du test
1. Version figée : on teste le prompt tel quel (v4 pour le plan 15 min, scalping v2 pour le 5 min). Toute modification = nouvelle version, et les compteurs repartent à zéro pour cette version.
2. On note TOUS les setups proposés, pris ou non. Un setup non pris mais déclenché est suivi « sur le papier » jusqu'au TP ou au stop.
3. Taille constante : 0,01 lot (ou la taille calculée par le prompt), jamais plus, pour que chaque trade compte pareil.
4. Exécution mécanique : entrée seulement si le déclencheur est complet, stop et TP du plan, aucune modification pendant le trade (sauf stop au point d'entrée prévu par le plan).
5. Résultat en R (résultat ÷ risque initial), pas en euros.
6. Échantillon minimum : 30 setups déclenchés par version avant de conclure.

## Ce qu'on mesure (dans journal/trades.md)
- Taux de réussite (% de trades gagnants).
- Gain moyen et perte moyenne, en R.
- Espérance = (taux de réussite × gain moyen) − (taux de perte × perte moyenne). Positive = la méthode gagne.
- Série de pertes la plus longue et baisse maximale (drawdown) en R.
- Setups « PAS DE TRADE » : combien de jours sans setup (une bonne méthode en a beaucoup).
- Écart exécution : résultat des setups pris vs résultat « sur le papier » de tous les setups.

## Accélérer avec le mode Replay de TradingView
- Le mode Replay rejoue le passé bougie par bougie : on peut tester une journée passée en 20 minutes.
- Procédure : choisir une date passée (replay_start), faire l'analyse avec le prompt SANS regarder la suite, noter les setups, puis avancer les bougies (replay_step / replay_autoplay) et noter le résultat.
- Règle stricte : aucune information postérieure au point de départ du replay ne doit être utilisée.
- Les trades en replay se notent à part (colonne « Mode » = replay) et ne se mélangent pas aux trades en direct.
- Autorisations d'avance en mode test : chart_set_timeframe, replay_start, replay_step, replay_autoplay, replay_status, replay_stop et toutes les lectures, sans redemander. Interdits : replay_trade, tout tracé, tout ordre.
- Avancer avec replay_step { count: N } (plusieurs bougies en un appel). Le current_date renvoyé peut retarder d'une bougie : avant les 3 dernières bougies, avancer une par une et vérifier la dernière bougie avec data_get_ohlcv.
- replay_start remet le graphique en 5 min : repasser en 15 min juste après, puis vérifier le point de replay.
- Figer le plan dans un fichier (journal/replay_AAAA-MM-JJ_plan.md) AVANT d'avancer.

## Verdict (après 30 setups par version)
- Espérance > +0,2 R et drawdown supportable : la méthode est exploitable (en démo d'abord, puis en réel avec un risque de 0,5 % par trade).
- Espérance entre 0 et +0,2 R : prometteur, continuer le test.
- Espérance ≤ 0 : la méthode ne marche pas en l'état ; analyser les pertes par type d'erreur avant de modifier les règles.
