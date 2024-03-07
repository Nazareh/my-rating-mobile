import 'package:flutter/material.dart';
import 'package:my_rating_app_mobile/domain/player.dart';

class SearchPlayer extends SearchDelegate<Player> {
  Function callback;

  SearchPlayer({required this.callback});

  final List<Player> searchList = [
    Player(displayName: 'John Doe', email: 'johndoes@gmail' ),
    Player(displayName: 'Jane Doe', email: 'janedoes@gmail'),
    Player(displayName: 'John Smith', email: 'johnsmith@gmail'),
    Player(displayName: 'Jane Smith', email: 'janesmith@gmail'),
    Player(displayName: 'Homer Simpson', email: 'homersimpson@gmail'),
    Player(displayName: 'Marge Simpson', email: 'margesimpson@gmail'),
    Player(displayName: 'Bart Simpson', email: 'bartsimpson@gmail'),
    Player(displayName: 'Lisa Simpson', email: 'lisasimpson@gmail'),
    Player(displayName: 'Maggie Simpson', email: 'maggiesimpson@gmail'),



  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Player> searchResults = searchList
        .where((item) => item.displayName.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResults[index].displayName),
          onTap: () {
            // Handle the selected search result.
            close(context, searchResults[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Player> suggestionList = query.isEmpty
        ? searchList
        : searchList
        .where((item) => item.displayName.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index].displayName),
          onTap: ()  {
            callback(suggestionList[index]);
            Navigator.pop(context);
            // query = suggestionList[index].displayName;
            // Show the search results based on the selected suggestion.
          },
        );
      },
    );
  }
}
