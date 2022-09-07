# Hangman

A flutter project of the game hangman
## Screenshots
<img src="images\Screenshot_20220907-153942.jpg" alt="drawing" width="200"/> <img src="images\Screenshot_20220907-154621.jpg" alt="drawing" width="200"/> <img src="images\Screenshot_20220907-154633.jpg" alt="drawing" width="200"/> <img src="images\Screenshot_20220907-154650.jpg" alt="drawing" width="200"/> <img src="images\Screenshot_20220907-154741.jpg" alt="drawing" width="200"/> <img src="images\Screenshot_20220907-154818.jpg" alt="drawing" width="200"/>

## Dependencies

The project has the following dependencies:

``` yaml
    rxdart: 
    english_words: 
    shared_preferences: 
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
You will need to execute a **pub get** to get the required packages.


