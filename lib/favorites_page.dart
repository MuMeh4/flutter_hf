import 'package:flutter/material.dart';
import 'package:flutter_hf/models/favorite_list_provider.dart';
import 'package:flutter_hf/results_list.dart';
import 'package:flutter_hf/ui_elements/buttons.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {


  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  bool ascendingSort = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 83, left: 68, right: 68, bottom: 24),
            child: Center(
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFFFFFF),
                    ),
                    children: [
                      TextSpan(
                        text: 'Favorite games',
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                )
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 0, bottom: 0, left: 23, right: 23),
                child: FilledButton(
                  onPressed: null,
                  child: null,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) {
                      return const Color(0xFFFFFFFF);
                    }
                    ),
                    fixedSize: MaterialStateProperty.resolveWith((states) {
                      return const Size(383, 63);
                    }),
                  ),
                ),
              ),
              Wrap(
                spacing: 25,
                children: [
                  ChoiceChip(
                    label: const Text(
                      '  Lowest price  ',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      )
                    ),
                    selected: ascendingSort,
                    onSelected: (_) {
                      setState(() {
                        ascendingSort = true;
                      });
                    },
                    color: MaterialStateColor.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {
                        return const Color(0xFF08EBC2);
                      }
                      return const Color(0xFFFFFFFF);
                    }),
                    showCheckmark: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(
                        color: Color(0x00000000),
                        width: 2,
                      ),
                    ),
                  ),
                  ChoiceChip(
                    label: const Text(
                      '  Highest price  ',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    selected: ascendingSort == false,
                    onSelected: (_) {
                      setState(() {
                        ascendingSort = false;
                      });
                    },
                    color: MaterialStateColor.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {
                        return const Color(0xFF08EBC2);
                      }
                      return const Color(0xFFFFFFFF);
                    }),
                    showCheckmark: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(
                        color: Color(0x00000000),
                        width: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          GamesList(games: context.watch<FavoriteListProvider>().games, ascendingSort: ascendingSort),
          BlueButton(
            onPressed: () {
              Navigator.pop(context);
            },
            text: 'Go back to search',
          ),
        ],
      ),
      backgroundColor: const Color(0xFF333333),
    );
  }
}

