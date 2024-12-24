import 'package:flutter/material.dart';
import 'package:lab2/provider/jokes_provider.dart';
import 'package:provider/provider.dart';

class FavoriteJokesView extends StatelessWidget {
  const FavoriteJokesView({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteJokes = context.watch<JokesProvider>().favoriteJokes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Jokes'),
      ),
      body: favoriteJokes.isNotEmpty
          ? ListView.builder(
              itemCount: favoriteJokes.length,
              itemBuilder: (context, index) {
                final joke = favoriteJokes[index];
                return ListTile(
                  title: Text(joke.setup),
                  subtitle: Text(joke.punchline),
                  trailing: IconButton(
                    icon: Icon(
                      joke.isFavorite ? Icons.favorite : Icons.favorite_border,
                    ),
                    onPressed: () {
                      context.read<JokesProvider>().toggleFavorite(joke);
                    },
                  ),
                );
              },
            )
          : const Center(
              child: Text('No favorite jokes yet.'),
            ),
    );
  }
}
