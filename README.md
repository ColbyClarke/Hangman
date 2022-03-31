# Hangman

A flutter project of the game hangman

## Dependencies

The project has the following dependencies:

``` yaml
    rxdart: ^0.27.3
    english_words: ^4.0.0
    shared_preferences: ^2.0.13
```

- rxdart: Extends the capabilities of Dart [Streams](https://api.dart.dev/stable/2.16.2/dart-async/Stream-class.html) and [StreamControllers](https://api.dart.dev/stable/2.16.2/dart-async/StreamController-class.html).
- english_words: A package containing the most ~5000 used English words.
- shared_preferences: Used to persist data (highscore)

## Structure

- The game is played by clicking on the floating action button in the bottom right corner.
- This fetches a random word from english_words package.
- The default number of guesses is 6. Lives remaining is depicted by asset images in the appropriate hangman shapes.

## How to run

Download the source code from the github repository.
You will need to do a pub get.
You may have to turn on developer options to get certain packages.


