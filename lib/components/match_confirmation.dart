import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../util/string_utils.dart';
import './flash_message.dart';
import './my_button.dart';
import '../domain/match.dart';

class MatchConfirmation extends StatelessWidget {
  const MatchConfirmation({super.key});

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
            children: <Widget>[
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: matches.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade50,
                            border: const Border(
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
                                Text(DateTime.fromMillisecondsSinceEpoch(matches
                                        .elementAt(index)
                                        .startTime
                                        .millisecondsSinceEpoch)
                                    .toString()),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              child: Text(
                                                  textAlign: TextAlign.start,
                                                  '${shortenName(matches.elementAt(index).team1.player1.name)} / ${shortenName(matches.elementAt(index).team1.player2.name)}'),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              child: Text(
                                                  textAlign: TextAlign.start,
                                                  '${shortenName(matches.elementAt(index).team2.player1.name)} / ${shortenName(matches.elementAt(index).team2.player2.name)}'),
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
                                                  padding: EdgeInsets.all(5),
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
                                                  padding: EdgeInsets.all(5),
                                                  child: Text(matches
                                                      .elementAt(index)
                                                      .sets[i]
                                                      .team2Score
                                                      .toString()))
                                          ],
                                        ),
                                      ]),
                                      // Column(children: [
                                      //   Row(
                                      //       mainAxisAlignment:
                                      //           MainAxisAlignment.spaceAround,
                                      //       children: [
                                      //         Text(
                                      //             textAlign: TextAlign.center,
                                      //             '${shortenName(matches.elementAt(index).team1.player1.name)} / ${shortenName(matches.elementAt(index).team1.player2.name)}'),
                                      //         Row(
                                      //           children: [
                                      //             for (int i = 0;
                                      //                 i <
                                      //                     matches
                                      //                         .elementAt(index)
                                      //                         .sets
                                      //                         .length;
                                      //                 i++)
                                      //               Container(
                                      //                   padding: EdgeInsets.all(5),
                                      //                   child: Text(matches
                                      //                       .elementAt(index)
                                      //                       .sets[i]
                                      //                       .team1Score
                                      //                       .toString()))
                                      //           ],
                                      //         )
                                      //       ]),
                                      //   const SizedBox(
                                      //     // width: 125,
                                      //     child: Divider(),
                                      //   ),
                                      //   Row(children: [
                                      //     const SizedBox(width: 10),
                                      //     Text(
                                      //         textAlign: TextAlign.center,
                                      //         '${shortenName(matches.elementAt(index).team2.player1.name)} / ${shortenName(matches.elementAt(index).team2.player2.name)}'),
                                      //     Row(
                                      //       children: [
                                      //         for (int i = 0;
                                      //             i <
                                      //                 matches
                                      //                     .elementAt(index)
                                      //                     .sets
                                      //                     .length;
                                      //             i++)
                                      //           Container(
                                      //               padding: EdgeInsets.all(5),
                                      //               child: Text(matches
                                      //                   .elementAt(index)
                                      //                   .sets[i]
                                      //                   .team2Score
                                      //                   .toString()))
                                      //       ],
                                      //     )
                                      //   ]),

                                      // ])
                                    ]),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      MyButton(
                                          color: Colors.red.shade400,
                                          onTap: () {
                                            showFlashMessage(
                                                context,
                                                'Match Rejeced',
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
