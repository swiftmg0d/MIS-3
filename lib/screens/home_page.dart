import 'package:flutter/material.dart';
import 'package:lab2/provider/jokes_provider.dart';
import 'package:lab2/screens/favorite_jokes_view.dart';
import 'package:lab2/screens/jokes_view.dart';
import 'package:lab2/widgets/random_joke_dialog.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoriteJokesView(),
                ),
              );
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.ads_click),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const RandomJokeDialog();
              },
            );
          },
        ),
      ),
      body: Center(
        child: FutureBuilder<List<String>>(
          future: context.watch<JokesProvider>().categories,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index]),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    leading: Icon(
                      context.watch<JokesProvider>().getCategoryIcon(snapshot.data![index]),
                      color: Colors.deepPurple,
                    ),
                    tileColor: const Color.fromARGB(255, 255, 255, 255),
                    trailing: const Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JokesView(category: snapshot.data![index]),
                        ),
                      );
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
