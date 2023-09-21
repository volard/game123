import 'package:game123/game/game_logic.dart';

var decisionTree = [];

List<List<int>> getDecisionLayer({required List<int> gameState, required int pendingNumber}){
  List<List<int>> layer = [];

  // Generate all simple additions
  for (var i = 0; i < gameState.length; i++){
    var newState = List.of(gameState);
    newState[i] += pendingNumber;
    layer.add(newState);
  }

  // Generate all double moves additions
  if (!isFirstMove){
    for (var i = 0; i < gameState.length; i++){
      if (gameState[i].isEven){
        for (var j = 0; j < gameState.length; j++){
          if (i == j) continue;

          var newState = List.of(gameState);
          newState[j] += (i/2) as int;
          layer.add(newState);
        }
      }
    }
  }

  return layer;
}


minimax({required state, depth = 10}){
  // maximizing by default
  var maxEva = -999999;
  // for each child of node do
  //   eva= minimax(child, depth-1, false)
  // maxEva= max(maxEva,eva)        //gives Maximum of the values
  // return maxEva
  }



getBestNextState(){

}