import 'package:flutter/material.dart';
import 'package:flutter_hf/models/game.dart';
import 'package:flutter_hf/online/firestore.dart';

class GameTile extends StatefulWidget {
  final Game game;
  final Function(Game)? onFavoriteChange;

  const GameTile({super.key, required this.game, this.onFavoriteChange});

  @override
  State<GameTile> createState() => _GameTileState();
}

class _GameTileState extends State<GameTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(
          color: Color(0xFF858585),
          width: 1,
        ),
      ),
      margin: const EdgeInsets.only(top: 6, bottom: 6),
      color: const Color(0xFF5A5A5A),
      child: ListTile(
        title: Text(widget.game.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFFFFFFFF),
          ),
        ),
        subtitle: Text(
          '\$${widget.game.price}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Color(0xFFFFFFFF),
          ),
        ),
        trailing: IconButton(
          icon: SizedBox(
            width: 40,
            height: 40,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Icon(
                    widget.game.isFavorite ? Icons.circle : Icons.circle_outlined,
                    color: const Color(0xFF08EBC2),
                    size: 40,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.star,
                    color: widget.game.isFavorite ? const Color(0xFF5A5A5A) : const Color(0xFF08EBC2),
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          onPressed: () {
            setState(() {
              toggleFavorite().whenComplete(() {
                widget.game.isFavorite = !widget.game.isFavorite;
                widget.onFavoriteChange?.call(widget.game);
              });
            });
          },
        ),
        contentPadding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 0),
      ),
    );
  }

  Future<void> toggleFavorite() async {
    if (widget.game.isFavorite) {
      FirestoreService.removeFavorite("user1", widget.game.id);
    } else {
      FirestoreService.addFavorite("user1", widget.game.id);
    }
  }
}
