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
}