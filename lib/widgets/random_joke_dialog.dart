import 'package:flutter/material.dart';
import 'package:lab2/services/api_services.dart';

class RandomJokeDialog extends StatelessWidget {
  const RandomJokeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Random joke of the day'),
      content: SizedBox(
        width: 300.0,
        child: FutureBuilder(
          future: ApiServices.getRandomJokes(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    snapshot.data!.setup,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromARGB(255, 33, 36, 34),
                    ),
                  ),
                  Text(snapshot.data!.punchline),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
