import 'package:cloud_firestore/cloud_firestore.dart';

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

  static Future<List<int>> getFavorites(String userId) async {
    final doc = await _db.collection('users').doc(userId).get();
    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      return List<int>.from(data['favorites']);
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