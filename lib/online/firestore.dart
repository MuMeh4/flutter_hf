import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import '../models/game.dart';

class FirestoreService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addFavorite(String userId, int gameId) async {
    final docRef = _db.collection('users').doc(userId);
    final doc = await docRef.get();
    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      final favorites = data['favorites'] as List<dynamic>;
      if (!favorites.contains(gameId)) {
        favorites.add(gameId);
        await docRef.update({'favorites': favorites});
      }
    } else {
      await docRef.set({'favorites': [gameId]});
    }
  }

  static Future<void> removeFavorite(String userId, int gameId) async {
    final docRef = _db.collection('users').doc(userId);
    final doc = await docRef.get();
    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      final favorites = data['favorites'] as List<dynamic>;
      if (favorites.contains(gameId)) {
        favorites.remove(gameId);
        await docRef.update({'favorites': favorites});
      }
    }
  }

  static Future<List<Game>> getFavorites(String userId) async {
    final doc = await _db.collection('users').doc(userId).get();
    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      List<Game> games = [];
      final favorites = data['favorites'] as List<dynamic>;
      for (int gameId in favorites) {
        final result = await http.get(Uri.parse('https://www.cheapshark.com/api/1.0/games?id=$gameId'));
        if (result.statusCode == 200) {
          final jsonData = json.decode(result.body);
          var game = Game.fromJson(jsonData);
          game.id = gameId;
          game.isFavorite = true;
          games.add(game);
        }
      }
      return games;
    } else {
      return [];
    }
  }

  static Future<bool> isFavorite(String userId, int gameId) async {
    final doc = await _db.collection('users').doc(userId).get();
    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      final favorites = data['favorites'] as List<dynamic>;
      return favorites.contains(gameId);
    } else {
      return false;
    }
  }
}