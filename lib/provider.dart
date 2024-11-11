import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freedom_app/models/job.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // For UTF8 encoding

class FavoritesProvider with ChangeNotifier {
  final List<Job> _favorites = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Job> get favorites => _favorites;

  bool isFavorite(Job job) {
    return _favorites.any((fav) => fav.urls == job.urls);
  }

  // Generate a unique, safe document ID based on job.urls using a hash function
  String _generateDocId(String url) {
    final bytes = utf8.encode(url); // Convert URL to bytes
    final digest = sha256.convert(bytes); // Generate SHA256 hash
    return digest.toString(); // Convert hash to a string that can be used as a document ID
  }

  Future<void> addFavorite(Job job) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Use the hashed URL to generate a safe document ID
      final docId = _generateDocId(job.urls);

      final docRef = _firestore
          .collection('Favorites')
          .doc(docId); // Safe document ID

      await docRef.set({
        'profession': job.profession,
        'city': job.city,
        'salary': job.salary,
        'urls': job.urls,
      });

      _favorites.add(job);
      notifyListeners();
    }
  }

  Future<void> removeFavorite(Job job) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final docId = _generateDocId(job.urls);

      final docRef = _firestore
          .collection('Favorites')
          .doc(docId); // Safe document ID

      await docRef.delete();

      _favorites.removeWhere((fav) => fav.urls == job.urls);
      notifyListeners();
    }
  }

  Future<void> loadFavorites() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('Favorites')
          .get();

      _favorites.clear();
      for (var doc in snapshot.docs) {
        _favorites.add(Job(
          profession: doc['profession'],
          city: doc['city'],
          salary: doc['salary'],
          urls: doc['urls'], conditions: '', relocation: '', gender: '', age: 0, education: [], experience: '', workExperience: [], skills: '',
        ));
      }
      notifyListeners();
    }
  }
}
