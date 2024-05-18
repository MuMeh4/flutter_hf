import 'package:flutter/material.dart';
import 'package:flutter_hf/online/firestore.dart';
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
  List<Game> results = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Game>>(
      future: widget.searchQuery != '' ? fetchResults(widget.searchQuery) : fetchFavorites(),
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
                  return GameTile(game: results[index], onFavoriteChange: widget.searchQuery == '' ? removeFavorite : null);
                },
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
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

  void removeFavorite(Game game) {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        results.remove(game);
      });
    });
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

Future<List<Game>> fetchFavorites() async {
  final favorites = await FirestoreService.getFavorites('user1');
  List<Game> favoriteGames = [];
  for (var favorite in favorites) {
    final response = await http.get(Uri.parse('https://www.cheapshark.com/api/1.0/games?id=$favorite'));
    if (response.statusCode == 200) {
      favoriteGames.add(gameFromJson(response.body, favorite));
    } else {
      throw Exception('Failed to load games');
    }
  }
  print('Fetched favorites');
  return favoriteGames;
}

Game gameFromJson(String str, int id) {
  var jsonData = json.decode(str);
  double price = double.parse(jsonData['deals'][0]['price']);
  for (var deal in jsonData['deals']) {
    if (double.parse(deal['price']) < price) {
      price = double.parse(deal['price']);
    }
  }
  return Game(
    id: id,
    title: jsonData['info']['title'],
    price: price,
    isFavorite: true,
  );
}

Future<List<Game>> gamesFromJson(String str) async {
  var jsonData = json.decode(str);
  List<Game> games = [];
  for (var g in jsonData) {
    Game game = Game(
      id: int.parse(g['gameID']),
      title: g['external'],
      price: double.parse(g['cheapest']),
      isFavorite: await FirestoreService.isFavorite('user1', int.parse(g['gameID'])),
    );
    games.add(game);
  }
  return games;
}
