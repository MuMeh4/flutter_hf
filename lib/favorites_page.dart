import 'package:flutter/material.dart';
import 'package:flutter_hf/results_list.dart';
import 'package:flutter_hf/ui_elements/buttons.dart';

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
            margin: const EdgeInsets.only(top: 83, left: 68, right: 68),
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
          Wrap(
            spacing: 20,
            children: [
              ChoiceChip(
                label: const Text('Lowest price'),
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
              ),
              ChoiceChip(
                label: const Text('Highest price'),
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
              ),
            ],
          ),
          ResultsList(),
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

