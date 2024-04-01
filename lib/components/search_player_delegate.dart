import 'package:flutter/material.dart';
import 'package:my_rating_app_mobile/domain/player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchPlayer extends SearchDelegate<Player> {
  Function callback;

  SearchPlayer({required this.callback});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('player').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        var filteredData = snapshot.data!.docs
            .where((element) => element['name']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();

        return ListView.builder(
          itemCount: filteredData.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(filteredData[index]['name']),
              onTap: () {
                close(
                    context,
                    Player.fromJson(
                        filteredData[index] as Map<String, dynamic>));
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('player').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        print(snapshot.data!.docs);

        var filteredData = snapshot.data!.docs
            .where((element) => element['name'].toString().toLowerCase().contains(query.toLowerCase()))
            .map((e) => e.data() as Map<String, dynamic>)
            .toList();

        return ListView.builder(
          itemCount: filteredData.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(filteredData[index]['name']),
              onTap: () {
                callback(
                    Player.fromJson(filteredData[index]));
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}
