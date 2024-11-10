import 'package:flutter/material.dart';
import 'package:freedom_app/models/job.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Job> _favorites = []; // Private list of favorite jobs

  // Getter for the favorites list
  List<Job> get favorites => _favorites;

  // Method to add a job to favorites
  void addFavorite(Job job) {
    if (!_favorites.contains(job)) {
      _favorites.add(job);
      job.isFavorite = true; // Assuming the Job model has an isFavorite attribute
      notifyListeners(); // Notify listeners about the update
    }
  }

bool isFavorite(Job job) {
  return _favorites.contains(job);
}
  // Method to remove a job from favorites
  void removeFavorite(Job job) {
    if (_favorites.contains(job)) {
      _favorites.remove(job);
      job.isFavorite = false; // Assuming the Job model has an isFavorite attribute
      notifyListeners(); // Notify listeners about the update
    }
  }

  // Method to toggle a job's favorite status
  void toggleFavorite(Job job) {
    if (_favorites.contains(job)) {
      removeFavorite(job);
    } else {
      addFavorite(job);
    }
  }
}
