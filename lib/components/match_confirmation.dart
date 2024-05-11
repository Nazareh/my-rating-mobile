import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../domain/player.dart';
import '../util/match_utils.dart';
import '../util/string_utils.dart';
import './flash_message.dart';
import './my_button.dart';
import '../domain/match.dart';

class MatchConfirmation extends StatelessWidget {
  final String loggedPlayerId;
  const MatchConfirmation({super.key, required this.loggedPlayerId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('match').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Text(''),
          );
        }

        var matches = snapshot.data!.docs
            .map((e) => e.data() as Map<String, dynamic>)
            .map((e) => Match.fromJson(e))
            .toList();

        return SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Text(
                  'Matches pending confirmation',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: matches.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(
                                  color: Colors.yellowAccent,
                                  width: 5.0,
                                  style: BorderStyle.solid),
                            ),
                          ),
                          child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(children: [
                                Text(DateFormat('E, d MMM yyyy h:mm a').format(
                                    DateTime.fromMillisecondsSinceEpoch(matches
                                        .elementAt(index)
                                        .startTime
                                        .millisecondsSinceEpoch))),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              child: Row(
                                                children: [
                                                  PlayerName(
                                                      player: matches
                                                          .elementAt(index)
                                                          .team1
                                                          .player1),
                                                  const Text(' / '),
                                                  PlayerName(
                                                      player: matches
                                                          .elementAt(index)
                                                          .team1
                                                          .player2),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              child: Row(
                                                children: [
                                                  PlayerName(
                                                      player: matches
                                                          .elementAt(index)
                                                          .team2
                                                          .player1),
                                                  const Text(' / '),
                                                  PlayerName(
                                                      player: matches
                                                          .elementAt(index)
                                                          .team2
                                                          .player2),
                                                ],
                                              ),
                                            ),
                                          ]),
                                      Column(children: [
                                        Row(
                                          children: [
                                            for (int i = 0;
                                                i <
                                                    matches
                                                        .elementAt(index)
                                                        .sets
                                                        .length;
                                                i++)
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Text(matches
                                                      .elementAt(index)
                                                      .sets[i]
                                                      .team1Score
                                                      .toString()))
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            for (int i = 0;
                                                i <
                                                    matches
                                                        .elementAt(index)
                                                        .sets
                                                        .length;
                                                i++)
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Text(matches
                                                      .elementAt(index)
                                                      .sets[i]
                                                      .team2Score
                                                      .toString()))
                                          ],
                                        ),
                                      ]),
                                    ]),
                                if (matchPlayersAsSet(matches.elementAt(index))
                                        .firstWhere(
                                            (e) => e.id == loggedPlayerId)
                                        .status !=
                                    'APPROVED')
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        MyButton(
                                            color: Colors.red.shade400,
                                            onTap: () {
                                              showFlashMessage(
                                                  context,
                                                  'Match Rejected',
                                                  MessageType.error);
                                            },
                                            text: 'REJECT'),
                                        MyButton(
                                            color: Colors.green,
                                            onTap: () {
                                              showFlashMessage(
                                                  context,
                                                  'Match Approved',
                                                  MessageType.success);
                                            },
                                            text: 'APPROVE')
                                      ])
                              ])),

                          // const Text('Some text')
                        ));
                  })
            ],
          ),
        );
      },
    );
  }
}

class PlayerName extends StatelessWidget {
  final Player player;

  const PlayerName({super.key, required this.player});

  Icon _getIcon(String? status) {
    if (status == 'PENDING') {
      return const Icon(
        Icons.timelapse_rounded,
        color: Colors.yellow,
      );
    }
    if (status == 'REJECTED') {
      return const Icon(
        Icons.block,
        color: Colors.red,
      );
    }
    if (status == 'APPROVED') {
      return const Icon(Icons.check, color: Colors.green);
    }

    return const Icon(Icons.error, color: Colors.red);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Text('${shortenName(player.name)}'), _getIcon(player.status)],
    );
  }
}
