class Jokes {
  final String type;
  final String setup;
  final String punchline;
  final int id;
  bool isFavorite;

  Jokes({
    required this.type,
    required this.setup,
    required this.punchline,
    required this.id,
    this.isFavorite = false,
  });

  factory Jokes.fromJson(Map<String, dynamic> json) {
    return Jokes(
      type: json['type'],
      setup: json['setup'],
      punchline: json['punchline'],
      id: json['id'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'setup': setup,
      'punchline': punchline,
      'id': id,
      'isFavorite': isFavorite,
    };
  }
}
