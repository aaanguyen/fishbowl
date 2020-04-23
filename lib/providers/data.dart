import 'package:flutter/material.dart';

class Data extends ChangeNotifier {
  List<Map<String, dynamic>> activeCardSet;
  List<Map<String, dynamic>> playingDeck;
  int numberOfRounds = 3;
  int numberOfPlayers = 6;
  bool scoreByPoints = false;
  int deckSize = 42;
  int currentRound = 1;
  int cardsRemaining = 42;
  bool isGuessButtonPressed = false;
  int team1Score = 0;
  int team2Score = 0;
  bool countingScoreForTeam1 = true;

  void resetGameState() {
    numberOfRounds = 3;
    numberOfPlayers = 6;
    scoreByPoints = false;
    deckSize = 42;
    currentRound = 1;
    cardsRemaining = 42;
    isGuessButtonPressed = false;
    team1Score = 0;
    team2Score = 0;
    countingScoreForTeam1 = true;
  }

  void updateActiveCardSet(List<Map<String, dynamic>> newCardSet) {
    activeCardSet = newCardSet;
    notifyListeners();
  }

  void updatePlayingDeck(List<Map<String, dynamic>> deck) {
    playingDeck = deck;
    notifyListeners();
  }

  void shufflePlayingDeck() {
    playingDeck.shuffle();
    notifyListeners();
  }

  void updateNumberOfRounds(int number) {
    numberOfRounds = number;
    notifyListeners();
  }

  void updateNumberOfPlayers(int number) {
    numberOfPlayers = number;
    if (number == 10) {
      deckSize = 50;
      cardsRemaining = 50;
    } else if (number == 6) {
      deckSize = 42;
      cardsRemaining = 42;
    } else {
      deckSize = 48;
      cardsRemaining = 48;
    }
    notifyListeners();
  }

  void updateScoreByPoints(String scoreBy) {
    if (scoreBy == 'Cards') {
      scoreByPoints = false;
    } else {
      scoreByPoints = true;
    }
    notifyListeners();
  }

  void updateCurrentRound() {
    currentRound++;
    notifyListeners();
  }

  void updateCardsRemaining(int number) {
    cardsRemaining = number;
    notifyListeners();
  }

  List<Map<String, dynamic>> getRandomCardMaps(int number) {
    activeCardSet.shuffle();
    return activeCardSet.sublist(0, number);
  }

  void addToCurrentTeamScore(int value) {
    if (scoreByPoints) {
      if (countingScoreForTeam1) {
        team1Score += value;
      } else {
        team2Score += value;
      }
    } else {
      if (countingScoreForTeam1) {
        team1Score++;
      } else {
        team2Score++;
      }
    }
  }

  void decideStartingTeam() {
    countingScoreForTeam1 = (team1Score <= team2Score) ? true : false;
  }

  void switchScoringTeam() {
    countingScoreForTeam1 = !countingScoreForTeam1;
  }
}
