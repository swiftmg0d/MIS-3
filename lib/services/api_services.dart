import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lab2/models/Jokes.dart';

class ApiServices {
  static Future<List<String>> getCategories() async {
    final response = await http.get(Uri.parse('https://official-joke-api.appspot.com/types'));
    if (response.statusCode == 200) {
      final List<dynamic> categories = jsonDecode(response.body);
      return categories.map((e) => e.toString()).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<List<Jokes>> getJokesByType(String type) async {
    final response = await http.get(Uri.parse('https://official-joke-api.appspot.com/jokes/$type/ten'));
    if (response.statusCode == 200) {
      final List<dynamic> jokes = jsonDecode(response.body);
      return jokes.map((e) => Jokes.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load jokes');
    }
  }

  static Future<Jokes> getRandomJokes() async {
    final response = await http.get(Uri.parse('https://official-joke-api.appspot.com/random_joke'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> joke = jsonDecode(response.body);
      return Jokes.fromJson(joke);
    } else {
      throw Exception('Failed to load jokes');
    }
  }
}
