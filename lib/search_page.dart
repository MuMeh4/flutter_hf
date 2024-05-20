import 'package:flutter/material.dart';
import 'package:flutter_hf/ui_elements/buttons.dart';
import 'package:flutter_hf/results_list.dart';

class SearchPage extends StatefulWidget {
  final String searchQuery;

  const SearchPage({super.key, this.searchQuery = ''});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 83, left: 68, right: 68, bottom: 24),
            child: Center(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 32,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFFFFFF),
                  ),
                  children: [
                    const TextSpan(
                      text: 'Search results for\n',
                    ),
                    TextSpan(
                      text: '${widget.searchQuery}...',
                      style: const TextStyle(
                        color: Color(0xFF08EBC2),
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              )
            ),
          ),
          ResultsList(searchQuery: widget.searchQuery),
          BlueButton(
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
            text: 'See favorites',
          ),
        ],
      ),
      backgroundColor: const Color(0xFF333333),
    );
  }
}
