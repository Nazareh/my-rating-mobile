
import 'package:my_rating_app_mobile/domain/player.dart';

import '../domain/match.dart';

Set<Player> matchPlayersAsSet(Match match){
  return {
    match.team1.player1, match.team1.player2, match.team2.player1, match.team2.player2
  };
}