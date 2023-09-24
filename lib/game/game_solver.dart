

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:game123/game/game_logic.dart';

// {"f" : [a, b, c], "a": pendingNumber}
int checkedMoves = 0;
class GameState{
  GameState(this.heapsState, this.pendingNumber);

  late List<int> heapsState;
  late int pendingNumber;
}

int getNextPendingNum({required List<int> numQueue, required int currentNum}){
  int indexOfCurrent = numQueue.indexOf(currentNum);
  if (indexOfCurrent == -1) throw Exception("The current number ${currentNum.toString()} can't be in the game with queue ${numQueue.toString()}");
  return numQueue[(indexOfCurrent + 1) % numQueue.length];
}

List<GameState> getDecisionLayer({required GameState gameState}){
  List<GameState> layer = [];

  // Generate all simple additions
  for (var i = 0; i < gameState.heapsState.length; i++){
    var newState = GameState(List.of(gameState.heapsState), getNextPendingNum(numQueue: numQueue, currentNum: gameState.pendingNumber));
    newState.heapsState[i] += gameState.pendingNumber;
    layer.add(newState);
  }

  // Generate all double moves additions
  if (!isFirstMove){
    for (var i = 0; i < gameState.heapsState.length; i++){
      if (gameState.heapsState[i].isEven){
        for (var j = 0; j < gameState.heapsState.length; j++){
          if (i == j) continue;

          var newState = GameState(List.of(gameState.heapsState), getNextPendingNum(numQueue: numQueue, currentNum: gameState.pendingNumber));
          newState.heapsState[j] += (gameState.heapsState[i]~/2);
          newState.heapsState[i] = newState.heapsState[i]~/2;
          layer.add(newState);
        }
      }
    }
  }

  return layer;
}

bool theStateIsNonsense({required GameState gameState, required allowedMaxInterval}){
  List<int> numsToCheck = List.of(gameState.heapsState);
  numsToCheck.sort();
  return ((numsToCheck[1] - numsToCheck[2]).abs() > allowedMaxInterval);
}

void printLayer({String prefix = "", required List<GameState> states}){
  String out = prefix;
  for (var item in states){
    out += "${item.heapsState}, ";
  }
  debugPrint(out);
}


minimax({required GameState state, required depth, required isMaximizingPlayer}){
  checkedMoves += 1;
  // when depth is reached or the state is nonsense, the calculation stops anyway
  if (depth == 0 || theStateIsNonsense(gameState: state, allowedMaxInterval: 10)){

    if (!moveWasVictorious(heaps: state.heapsState)) {
      return 0;
    } else{
      if (moveWasVictorious(heaps: state.heapsState)){
        // determine who won?
        if (isMaximizingPlayer){
          return 10;
        }
        else {
          return -10;
        }
      }
    }
  }
  // when someone won, return appropriate score for AI
  if (moveWasVictorious(heaps: state.heapsState)){
    if (isMaximizingPlayer){
      return 10;
    }
    else {
      return -10;
    }
  }

  var thisDecisionLayer = getDecisionLayer(gameState: state);

  if(isMaximizingPlayer){
    var value = 9999999;
    for (GameState child in thisDecisionLayer){
      value = min(value, minimax(state: child, depth: depth - 1, isMaximizingPlayer: false));
    }
    return value;
  }
  else{ // maximizing AI
    var value = -99999999;
    for (GameState child in thisDecisionLayer){
      value = max(value, minimax(state: child, depth: depth - 1, isMaximizingPlayer: true));
    }
    return value;
  }

  }


// NOTE its actually returns not nullable GameState but to calm down the linter its defined like that
GameState? getBestNextState(){
  checkedMoves = 0;
  var currentDecisionLayer = getDecisionLayer(gameState: GameState(heaps, getCurrentNumPending(ignoreDivisionMove: true)));
  int bestScore = -9999999999;
  int score;
  GameState? bestNextState;
  for (var state in currentDecisionLayer){
    score = minimax(state: state, depth: 5, isMaximizingPlayer: true);
    debugPrint("calculated score for ${state.heapsState} is $score");
    // return state;
    if (bestScore < score){
      bestScore = score;
      bestNextState = state;
    }
  }
  debugPrint("AI checked $checkedMoves moves :)");
  return bestNextState;
}