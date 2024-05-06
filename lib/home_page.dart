import 'package:flutter/material.dart';
import 'package:flutter_hf/ui_elements/buttons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = '';

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
              Navigator.pushNamed(context, '/search', arguments: searchQuery);
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
