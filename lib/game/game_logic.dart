import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:game123/game/game_solver.dart';
import 'package:get/get.dart';

List<int> heaps = [1, 2, 3].obs;
final List<int> numQueue = [3, 1, 2];
int queueCurrentIndex = 0;
int selectedHeapToDivide = -1;
bool isFirstMove = true;

enum GameStatus { ended, running }

enum PlayerType { human, computer }

var currentPlayerIndex = 0;
var turnOrder = generateTurnOrder();

PlayerType getCurrentPlayer() => turnOrder[currentPlayerIndex];

GameStatus getGameStatus() {
  if (moveWasVictorious(heaps: heaps)) return GameStatus.ended;
  return GameStatus.running;
}

void setSelectedHeapToDivide(int index) {
  if (index >= heaps.length || index < 0) {
    throw ArgumentError(
        "Provide correct heap index between 0 and ${heaps.length - 1}");
  }
  selectedHeapToDivide = index;
}

int getCurrentNumPending({bool ignoreDivisionMove = false}) =>
    isDivisionMovePerforming() && !ignoreDivisionMove
        ? heaps[selectedHeapToDivide] ~/ 2
        : numQueue[queueCurrentIndex];

void makeMove(int heapIndexToAdd) {
  isFirstMove = false;
  if (heapIndexToAdd >= heaps.length || heapIndexToAdd < 0) {
    throw ArgumentError(
        "Provide correct heap index between 0 and ${heaps.length - 1}");
  }

  if (isDivisionMovePerforming()) {
    if (selectedHeapToDivide == heapIndexToAdd) {
      heaps[heapIndexToAdd] += getCurrentNumPending(ignoreDivisionMove: true);
    } else {
      heaps[selectedHeapToDivide] ~/= 2;
      heaps[heapIndexToAdd] += heaps[selectedHeapToDivide];
    }
    stopDivisionMove();
  } else {
    heaps[heapIndexToAdd] += getCurrentNumPending();
  }

  if (moveWasVictorious(heaps: heaps)) return;

  queueCurrentIndex = (queueCurrentIndex + 1) % heaps.length;
  currentPlayerIndex = (currentPlayerIndex + 1) % turnOrder.length;
}

void performAiMove({required GameState? newGameState}) {
  heaps = newGameState!.heapsState;
  queueCurrentIndex = (queueCurrentIndex + 1) % heaps.length;
  currentPlayerIndex = (currentPlayerIndex + 1) % turnOrder.length;
}

void restart() {
  isFirstMove = true;
  heaps = [1, 2, 3];
  queueCurrentIndex = 0;
  selectedHeapToDivide = -1;
  turnOrder = generateTurnOrder();
  currentPlayerIndex = 0;
  if (getCurrentPlayer() == PlayerType.computer) {
    performAiMove(newGameState: getBestNextState());
    isFirstMove = false;
  }
}

void stopDivisionMove() {
  selectedHeapToDivide = -1;
}

bool isDivisionMovePerforming() => selectedHeapToDivide != -1;

List<PlayerType> generateTurnOrder() {
  final randomNumberGenerator = Random();
  bool isUserFirst = randomNumberGenerator.nextBool();
  // if (isUserFirst){
  return [PlayerType.human, PlayerType.computer];
  // }
  return [PlayerType.computer, PlayerType.human];
}

bool moveWasVictorious({required List<int> heaps}) {
  List<int> sortedHeaps = List.of(heaps);
  sortedHeaps.sort();
  return sortedHeaps[0] == sortedHeaps[1] || sortedHeaps[1] == sortedHeaps[2];
}
