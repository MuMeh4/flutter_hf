import 'package:flutter_hf/models/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hf/online/firestore.dart';

class FavoriteListProvider extends ChangeNotifier {
  List<Game> _games = [];
  get games => _games;

  FavoriteListProvider() {
    FirestoreService.getFavorites("user1").then((value) {
      _games = value;
      notifyListeners();
    });
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