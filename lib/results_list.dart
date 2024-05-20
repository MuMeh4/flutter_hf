import 'package:flutter/material.dart';
import 'package:flutter_hf/online/firestore.dart';
import 'package:flutter_hf/models/game.dart';
import 'package:flutter_hf/ui_elements/game_tile.dart';
import 'package:flutter_hf/models/favorite_list_provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class ResultsList extends StatefulWidget {
  final String searchQuery;

  const ResultsList({super.key, this.searchQuery = ''});

  @override
  State<ResultsList> createState() => _ResultsListState();
}

class _ResultsListState extends State<ResultsList> {
  List<Game> results = [];
  int _lastRefresh = 0;

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
                padding: const EdgeInsets.only(top: 0),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  return GameTile(game: results[index]);
                },
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Container(
            margin: const EdgeInsets.only(top: 23, bottom: 23, left: 23, right: 23),
            height: 500,
            width: 383,
            alignment: Alignment.center,
            child: Text(
              '${snapshot.error}',
              style: const TextStyle(
                color: Color(0xFFFFFFFF),
              ),
            ),
          );
        }
        return Container(
          margin: const EdgeInsets.only(top: 23, bottom: 23, left: 23, right: 23),
          height: 500,
          width: 383,
          child: const Center(
            child: CircularProgressIndicator(),
          )
        );
      },
    );
  }

  Future<List<Game>> fetchResults(String searchQuery) async {
    if (DateTime.timestamp().millisecondsSinceEpoch - _lastRefresh < 5000) {
      return results;
    }
    final response = await http.get(Uri.parse('https://www.cheapshark.com/api/1.0/games?title=$searchQuery'));
    if (response.statusCode == 200) {
      _lastRefresh = DateTime.timestamp().millisecondsSinceEpoch;
      return gamesFromJson(response.body);
    } else if (response.statusCode == 429) {
      // mock the results
      return [
        Game(
          id: 1,
          title: 'Game 1',
          price: 10.0,
          isFavorite: false,
        ),
        Game(
          id: 2,
          title: 'Game 2',
          price: 20.0,
          isFavorite: false,
        ),
        Game(
          id: 3,
          title: 'Game 3',
          price: 30.0,
          isFavorite: false,
        ),
      ];
    }
    else {
      throw Exception('Failed to load games');
    }
  }

  Future<List<Game>> gamesFromJson(String str) async {
    var jsonData = json.decode(str);
    List<Game> games = [];
    for (var g in jsonData) {
      Game game = Game(
        id: int.parse(g['gameID']),
        title: g['external'],
        price: double.parse(g['cheapest']),
        isFavorite: context.read<FavoriteListProvider>().isFavorite(int.parse(g['gameID'])),
      );
      games.add(game);
    }
    return games;
  }
}

class GamesList extends StatelessWidget {
  final List<Game> games;
  final bool ascendingSort;

  const GamesList({super.key, this.games = const [], this.ascendingSort = true});

  @override
  Widget build(BuildContext context) {
    if (!ascendingSort) {
      games.sort((a, b) => b.price.compareTo(a.price));
    } else {
      games.sort((a, b) => a.price.compareTo(b.price));
    }
    return Container(
      margin: const EdgeInsets.only(top: 23, bottom: 23, left: 23, right: 23),
      height: 500,
      width: 383,
      child: OverflowBox(
        maxHeight: 500,
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 0),
          itemCount: games.length,
          itemBuilder: (context, index) {
            return GameTile(game: games[index]);
          },
        ),
      ),
    );
  }
}