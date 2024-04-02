import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../util/string_utils.dart';
import '../domain/match.dart';

class MatchConfirmation extends StatelessWidget {
  final String name;

  MatchConfirmation(this.name);

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
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          constraints: const BoxConstraints(
                              minHeight: 75, maxHeight: 75),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade50,
                            border: const Border(
                              left: BorderSide(
                                  color: Colors.yellowAccent,
                                  width: 5.0,
                                  style: BorderStyle.solid),
                            ),
                          ),
                          child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              height: 40,
                              child: Text(
                                  textAlign: TextAlign.center,
                                  '${shortenName(matches.elementAt(index).team1.player1.id)}')),

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
