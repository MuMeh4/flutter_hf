class Game {
  int id;
  String title;
  double price;
  bool isFavorite;

  Game({
    required this.id,
    required this.title,
    required this.price,
    this.isFavorite = false,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    try {
      return Game(
        id: json['gameID'],
        title: json['external'],
        price: double.parse(json['cheapest']),
      );
    } catch (e) {
      return Game(
        id: 0,
        title: json['info']['title'],
        price: double.parse(json['deals'][0]['price']),
      );
    }
  }
}