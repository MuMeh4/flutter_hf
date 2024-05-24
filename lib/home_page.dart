import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hf/ui_elements/buttons.dart';
import 'package:provider/provider.dart';

import 'models/favorite_list_provider.dart';
import 'models/game.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<FavoriteListProvider>().init();
      return showDialog(
        context: context,
        builder: (context) {
          return FutureBuilder<Game?>(
            future: context.read<FavoriteListProvider>().getGameOnSale(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox.shrink();
              }
              var game = snapshot.data!;
              return AlertDialog(
                title: Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    style: ButtonStyle(
                      iconSize: MaterialStateProperty.resolveWith((states) {
                        return 40;
                      }),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                content: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 28,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),

                    ),
                    children: [
                      const TextSpan(
                        text: 'Your favorited game, ',
                      ),
                      TextSpan(
                        text: game.title,
                        style: const TextStyle(
                          color: Color(0xFF08EBC2),
                        ),
                      ),
                      const TextSpan(
                        text: ' is on sale!',
                      ),
                    ],
                  ),
                ),
                actions: [
                  BlueButton(text: 'See deal', onPressed: () {
                    Navigator.pushNamed(context, '/search', arguments: game.title);
                  }),
                  GrayButton(text: 'Go to search', onPressed: () {
                    Navigator.pop(context);
                  }),
                ],
                backgroundColor: const Color(0xFFFFFFFF),
                alignment: Alignment.center,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              );
            },
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 203, left: 40, right: 40),
              child: const Center(
                child: Text(
                  'Search for a game title',
                  style: TextStyle(
                    fontSize: 42,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFE5E5E5),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 62, left: 40, right: 40),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                style: const TextStyle(
                  color: Color(0xFF757575),
                  fontSize: 22,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFFFFFFF),
                  hintText: 'SEARCH...',
                  hintStyle: const TextStyle(
                    color: Color(0xFF757575),
                    fontSize: 22,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                  contentPadding: const EdgeInsets.only(top: 15, bottom: 15, left: 25, right: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(47),
                    borderSide: const BorderSide(
                      color: Color(0xFFDADADA),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(47),
                    borderSide: const BorderSide(
                      color: Color(0xFFDADADA),
                    ),
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 154)),
            BlueButton(text: 'Let\'s go', onPressed: () {
              Navigator.pushNamed(context, '/search', arguments: searchQuery.trim());
            }),
            WhiteButton(text: 'Favorites', onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            }),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF333333),
    );
  }
}
