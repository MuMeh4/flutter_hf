import 'package:flutter/material.dart';
import 'package:flutter_hf/home_page.dart';
import 'package:flutter_hf/search_page.dart';
import 'package:flutter_hf/favorites_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        '/home': (context) => const HomePage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/search') {
          final String? searchQuery = settings.arguments as String?;
          return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(
              opacity: animation,
              child: SearchPage(searchQuery: searchQuery ?? ''),
            );
            // return const SearchPage();
          });
        } else if (settings.name == '/favorites') {
          return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(
              opacity: animation,
              child: const FavoritesPage(),
            );
          });
        }
        return null;
      },
    );
  }
}
