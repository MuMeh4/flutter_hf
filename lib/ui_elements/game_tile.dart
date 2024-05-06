import 'package:flutter/material.dart';
import 'package:flutter_hf/models/game.dart';

class GameTile extends StatelessWidget {
  final Game game;

  const GameTile({super.key, required this.game});

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
        title: Text(game.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFFFFFFFF),
          ),
        ),
        subtitle: Text(
          '\$${game.price}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Color(0xFFFFFFFF),
          ),
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.stars_rounded,
            color: Color(0xFF08EBC2),
            size: 42,
          ),
          onPressed: () {},
        ),
        contentPadding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 0),
      ),
    );
  }
}
