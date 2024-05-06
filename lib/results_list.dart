import 'package:flutter/material.dart';
import 'package:flutter_hf/models/game.dart';
import 'package:flutter_hf/ui_elements/game_tile.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ResultsList extends StatefulWidget {
  final String searchQuery;

  const ResultsList({super.key, this.searchQuery = ''});

  @override
  State<ResultsList> createState() => _ResultsListState();
}

class _ResultsListState extends State<ResultsList> {
  String searchQuery = '';
  List<Game> results = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Game>>(
      future: fetchResults(widget.searchQuery),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          results = snapshot.data!;
          return Container(
            margin: const EdgeInsets.only(top: 23, bottom: 23, left: 23, right: 23),
            height: 500,
            width: 383,
            child: OverflowBox(
              maxHeight: 500,
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  return GameTile(game: results[index]);
                },
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

Future<List<Game>> fetchResults(String searchQuery) async {
  final response = await http.get(Uri.parse('https://www.cheapshark.com/api/1.0/games?title=$searchQuery'));
  if (response.statusCode == 200) {
    return gamesFromJson(response.body);
  } else {
    throw Exception('Failed to load games');
  }
}

List<Game> gamesFromJson(String str) {
  var jsonData = json.decode(str);
  List<Game> games = [];
  for (var g in jsonData) {
    Game game = Game(
      title: g['external'],
      price: double.parse(g['cheapest']),
    );
    games.add(game);
  }
  return games;
}
