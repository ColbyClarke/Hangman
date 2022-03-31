import 'package:flutter/material.dart';
import 'package:hangman/src/bloc/home_bloc.dart';
import 'package:hangman/src/models/game_state.dart';
import 'package:hangman/src/models/guess_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var bloc = HomeBloc();
  List<Image> images = [];

  final int charA = 'a'.codeUnitAt(0);

  @override
  void initState() {
    super.initState();
    if (mounted) {
      bloc.initBloc(context);
      images.add(const Image(
          fit: BoxFit.contain, image: AssetImage('assets/imgs/hm_blank.png')));
      images.add(const Image(
          fit: BoxFit.contain, image: AssetImage('assets/imgs/hm_1.png')));
      images.add(const Image(
          fit: BoxFit.contain, image: AssetImage('assets/imgs/hm_3.png')));
      images.add(const Image(
          fit: BoxFit.contain, image: AssetImage('assets/imgs/hm_5.png')));
      images.add(const Image(
          fit: BoxFit.contain, image: AssetImage('assets/imgs/hm_6.png')));
      images.add(const Image(
          fit: BoxFit.contain, image: AssetImage('assets/imgs/hm_8.png')));
      images.add(const Image(
          fit: BoxFit.contain, image: AssetImage('assets/imgs/hm_10.png')));
    }
  }

  @override
  void dispose() async {
    super.dispose();
    await bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () => showStats(), icon: const Icon(Icons.settings))
        ],
      ),
      body: StreamBuilder<GameState>(
        stream: bloc.gameState,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return loadingScreen();
          }
          switch (snapshot.data) {
            case GameState.lost:
              return lostScreen();
            case GameState.won:
              return wonScreen(false);
            case GameState.highscore:
              return wonScreen(true);
            case GameState.playing:
              return playingScreen();
            default:
              return loadingScreen();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => bloc.initialiseGame(),
        child: const Icon(Icons.play_circle_outline),
      ),
    );
  }

  showStats() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Stats'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("HighScore: ${bloc.highScore} letters remaining"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  showError(String error) async {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(error)));
  }

  showInfo(String info) async {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(info)));
  }

  Widget playingScreen() {
    return StreamBuilder<GuessState>(
        stream: bloc.guessState,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          switch (snapshot.data) {
            case GuessState.correct:
              Future.delayed(const Duration(milliseconds: 50))
                  .then((value) => showInfo("Correct!!"));

              break;
            case GuessState.incorrect:
              Future.delayed(const Duration(milliseconds: 50))
                  .then((value) => showError("Inorrect :("));

              break;
            case GuessState.guessed:
              Future.delayed(const Duration(milliseconds: 50))
                  .then((value) => showInfo("Already guessed"));

              break;
            default:
          }
          TextEditingController guessController = TextEditingController();
          List<Widget> word = bloc.word.map((e) {
            return bloc.correctLetters.contains(e)
                ? Text(String.fromCharCode(e),
                    style: const TextStyle(fontSize: 40))
                : const Text("_", style: TextStyle(fontSize: 40));
          }).toList();
          List<Widget> guesses = bloc.incorrectLetters
              .map((e) => Text(String.fromCharCode(e),
                  style: const TextStyle(fontSize: 40)))
              .toList();

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 200,
                  child: images[6 - bloc.guessesRemaining],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: word,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: guesses,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      padding: const EdgeInsets.only(right: 20),
                      child: TextField(
                        onSubmitted: (value) => guess(value),
                        controller: guessController,
                        maxLength: 1,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          String guess = guessController.text;
                          guess = guess.toLowerCase();
                          if (guess != "") {
                            int char = guess.codeUnitAt(0);
                            if (char < charA || char > charA + 26) {
                              showError("Invalid input");
                            } else {
                              bloc.addLetter(char);
                            }
                          } else {
                            showError("No value input");
                          }
                        },
                        child: const Text("Guess"))
                  ],
                ),
              ],
            ),
          );
        });
  }

  guess(String guess) {
    guess = guess.toLowerCase();
    if (guess != "") {
      int char = guess.codeUnitAt(0);
      if (char < charA || char > charA + 26) {
        showError("Invalid input");
      } else {
        bloc.addLetter(char);
      }
    } else {
      showError("No value input");
    }
  }

  Widget wonScreen(bool highscore) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Text(highscore ? "New high score!!!" : "Congratulations!!!!",
                style: const TextStyle(fontSize: 40))),
        const Center(
          child: Text("Word was: ", style: TextStyle(fontSize: 40)),
        ),
        Center(
          child: Text(String.fromCharCodes(bloc.word),
              style: const TextStyle(fontSize: 40)),
        ),
        Center(
          child: Text("Guesses remaining ${bloc.guessesRemaining}",
              style: const TextStyle(fontSize: 40)),
        ),
      ],
    );
  }

  Widget lostScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
            child: Text("You lost :(", style: TextStyle(fontSize: 40))),
        const Center(
          child: Text("Word was: ", style: TextStyle(fontSize: 40)),
        ),
        Center(
          child: Text(String.fromCharCodes(bloc.word),
              style: const TextStyle(fontSize: 40)),
        ),
      ],
    );
  }

  Widget loadingScreen() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("Welcome to hangman!"),
      ElevatedButton(
          onPressed: bloc.initialiseGame(), child: const Text("Click to play"))
    ]);
  }
}
