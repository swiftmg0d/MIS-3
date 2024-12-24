import 'package:flutter/material.dart';
import 'package:lab2/models/Jokes.dart';
import 'package:lab2/services/api_services.dart';

class JokesProvider extends ChangeNotifier {
  late final Future<List<String>> categories;
  late final Future<List<Jokes>> jokes;
  List<Jokes> favoriteJokes = [];

  JokesProvider() {
    categories = ApiServices.getCategories();
    jokes = categories.then((value) async {
      List<Jokes> allJokes = [];
      for (var element in value) {
        Future<List<Jokes>> newJokes = ApiServices.getJokesByType(element);
        List<Jokes> jokesList = await newJokes;
        allJokes.addAll(jokesList);
      }
      notifyListeners();
      return allJokes;
    });
  }

  void toggleFavorite(Jokes joke) {
    joke.isFavorite = !joke.isFavorite;
    if (joke.isFavorite) {
      favoriteJokes.add(joke);
    } else {
      favoriteJokes.remove(joke);
    }
    notifyListeners();
  }

  IconData? getCategoryIcon(String category) {
    switch (category) {
      case 'general':
        return Icons.category;
      case 'knock-knock':
        return Icons.doorbell;
      case 'programming':
        return Icons.code;
      case 'dad':
        return Icons.family_restroom;
      default:
        return Icons.category;
    }
  }
}
