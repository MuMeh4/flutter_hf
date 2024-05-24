import 'package:flutter_hf/models/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hf/online/firestore.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class FavoriteListProvider extends ChangeNotifier {
  List<Game> _games = [];
  get games => _games;

  FavoriteListProvider() {
    init();
  }

  Future<void> init() async {
    _games  = await FirestoreService.getFavorites("user1");
  }

  Future<Game?> getGameOnSale() async {
    for (Game game in _games) {
      var uri = Uri.encodeFull('https://www.cheapshark.com/api/1.0/deals?title=${game.title}&exact=1&onSale=1');
      var request = await http.get(Uri.parse(uri));
      if (request.statusCode == 200) {
        var jsonData = json.decode(request.body);
        if (jsonData.length > 0) {
          return game;
        }
      }
    }
    return null;
  }

  void addFavorite(Game game) {
    _games.add(game);
    notifyListeners();
    FirestoreService.addFavorite("user1", game.id);
  }

  void removeFavorite(Game game) {
    _games.remove(game);
    notifyListeners();
    FirestoreService.removeFavorite("user1", game.id);
  }

  bool isFavorite(int gameId) {
    return _games.any((element) => element.id == gameId);
  }
}