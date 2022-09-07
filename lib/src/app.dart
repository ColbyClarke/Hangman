import 'package:flutter/material.dart';
import 'package:hangman/src/screens/home_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hangman',
      theme: ThemeData.from(
              colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.teal,
      ).copyWith(background: const Color.fromARGB(255, 241, 252, 243)))
          .copyWith(
        cardColor: const Color.fromARGB(255, 232, 252, 237),
      ),
      onGenerateRoute: (settings) {
        if (settings.name == HomeScreen.routeName) {
          // final args = settings.arguments as Map;

          return MaterialPageRoute(
              builder: (context) => const HomeScreen(title: "Hangman"));
        }
        if (settings.name == '/') {
          // final args = settings.arguments as Map;

          return MaterialPageRoute(
              builder: (context) => const HomeScreen(title: "Hangman"));
        }
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
    );
  }
}
