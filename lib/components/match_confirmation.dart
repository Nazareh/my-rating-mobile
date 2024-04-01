import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MatchConfirmation extends StatelessWidget {
  final String name;

  MatchConfirmation(this.name);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('player').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        var matches = snapshot.data!.docs.length;
        // print(matches[0]['startTime']);
        return

          SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: <Widget>[
                const Text('Hey'),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 60,
                    itemBuilder: (context,index){
                      return  ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 50),
                              constraints: const BoxConstraints(minHeight: 350, maxHeight: 150),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.yellow.shade50,
                                border: const Border(
                                  left: BorderSide(
                                      color: Colors.yellowAccent, width: 5.0, style: BorderStyle.solid),
                                ),
                              ),
                              child: const Text('Some text')));
                    })
              ],
            ),
          );
      },
    );
  }
}
