import 'package:flutter/material.dart';
import 'package:lab2/models/Jokes.dart';
import 'package:lab2/provider/jokes_provider.dart';
import 'package:provider/provider.dart';

class JokesView extends StatefulWidget {
  const JokesView({super.key, required this.category});
  final String category;

  @override
  State<JokesView> createState() => _JokesViewState();
}

class _JokesViewState extends State<JokesView> {
  late Future<List<Jokes>> jokes;

  @override
  void initState() {
    super.initState();
    jokes = context.read<JokesProvider>().jokes.then(
          (value) => value.where((element) => element.type == widget.category).toList(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: Center(
        child: FutureBuilder<List<Jokes>>(
          future: jokes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final joke = snapshot.data![index];
                  return ListTile(
                    title: Text(joke.setup),
                    subtitle: const Text('Click to see the punchline'),
                    trailing: IconButton(
                      icon: Icon(
                        joke.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: joke.isFavorite ? Colors.red : null,
                      ),
                      onPressed: () {
                        setState(() {
                          context.read<JokesProvider>().toggleFavorite(joke);
                        });
                      },
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(joke.setup),
                            content: Text(joke.punchline),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              );
            } else {
              return const Text('No jokes available for this category.');
            }
          },
        ),
      ),
    );
  }
}
