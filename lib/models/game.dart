class Game {
  String title;
  double price;
  bool isFavorite;

  Game({
    required this.title,
    required this.price,
    this.isFavorite = false,
  });
}