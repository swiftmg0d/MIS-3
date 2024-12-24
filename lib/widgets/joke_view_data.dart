import 'package:flutter/material.dart';
import 'package:lab2/models/Jokes.dart';

class JokeViewData extends StatelessWidget {
  const JokeViewData({
    super.key,
    required this.jokes,
  });

  final Future<List<Jokes>> jokes;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Jokes>>(
      future: jokes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              snapshot.data![index].setup,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color.fromARGB(255, 33, 36, 34),
                              ),
                            ),
                            content: Text(snapshot.data![index].punchline),
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
                    title: Text(snapshot.data![index].setup),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    subtitle: const Text('Click to see the punchline'),
                  ),
                );
              },
            ),
          );
        } else {
          return const Text('No jokes available.');
        }
      },
    );
  }
}
