import 'package:flutter/cupertino.dart';
import 'package:hangman/src/models/game_state.dart';
import 'package:hangman/src/models/guess_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:english_words/english_words.dart';

import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class HomeBloc {
  BuildContext? context;
  final _gameStateSubject = BehaviorSubject.seeded(GameState.loading);
  final _guessStateSubject = BehaviorSubject.seeded(GuessState.none);
  List<int> correctLetters = [];
  List<int> incorrectLetters = [];
  List<int> letters = [];
  List<int> word = [];
  List<String> possibleWords = ["hello", "word", "leopard", "girrafe"];
  int guessesRemaining = 0;
  int lettersRemaining = 0;
  int highScore = 0;
  final String _highscorekey = "highscore";

  // streams
  Stream<GameState> get gameState => _gameStateSubject.stream;
  Stream<GuessState> get guessState => _guessStateSubject.stream;

  // setters
  Function(GameState) get setGameState => _gameStateSubject.sink.add;

  addLetter(int letter) {
    if (incorrectLetters.contains(letter) || correctLetters.contains(letter)) {
      _guessStateSubject.sink.add(GuessState.guessed);
      return;
    }
    if (word.contains(letter)) {
      correctLetters.add(letter);
      _guessStateSubject.sink.add(GuessState.correct);
      if (lettersRemaining > 1) {
        lettersRemaining--;
      } else {
        if (guessesRemaining > highScore) {
          _gameStateSubject.sink.add(GameState.highscore);
          updateHighscore(guessesRemaining);
        } else {
          _gameStateSubject.sink.add(GameState.won);
        }
      }
    } else {
      incorrectLetters.add(letter);
      _guessStateSubject.sink.add(GuessState.incorrect);
      if (guessesRemaining > 1) {
        guessesRemaining--;
      } else {
        _gameStateSubject.sink.add(GameState.lost);
      }
    }
  }

  initialiseGame() {
    guessesRemaining = 6;
    correctLetters = [];
    incorrectLetters = [];
    var intValue = Random().nextInt(possibleWords.length);
    word = possibleWords[intValue].codeUnits;
    letters = word.toSet().toList();
    lettersRemaining = letters.length;
    _guessStateSubject.sink.add(GuessState.ready);
    _gameStateSubject.sink.add(GameState.playing);
  }

  initBloc(BuildContext context) async {
    this.context = context;
    int charA = 'a'.codeUnitAt(0);
    letters = List.generate(26, (i) => charA + i);
    _gameStateSubject.sink.add(GameState.ready);
    possibleWords = all;
    await getStats();
  }

  Future close() async {
    _gameStateSubject.close();
    _guessStateSubject.close();
  }

  getStats() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(_highscorekey)) {
      highScore = prefs.getInt(_highscorekey) ?? 0;
    } else {
      prefs.setInt(_highscorekey, 0);
    }
  }

  updateHighscore(int hs) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_highscorekey, hs);
    highScore = hs;
  }
}
