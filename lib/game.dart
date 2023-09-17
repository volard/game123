import 'dart:math';
import 'package:get/get.dart';

List<int> heaps = [1, 2, 3].obs;
final List<int> numQueue = [3, 1, 2];
int queueCurrentIndex = 0;
int selectedHeapToDivide = -1;
final randomNumberGenerator = Random();
bool isUserFirst = randomNumberGenerator.nextBool();

void setSelectedHeapToDivide(int index){
  if (index >= heaps.length || index < 0) throw ArgumentError("Provide correct heap index between 0 and ${heaps.length-1}");
  selectedHeapToDivide = index;
}

int getCurrentNumPending({bool ignoreDivisionMove = false}) =>
   isDivisionMovePerforming() && !ignoreDivisionMove ? heaps[selectedHeapToDivide]~/2 : numQueue[queueCurrentIndex];

void makeMove(int heapIndexToAdd){
  if (heapIndexToAdd >= heaps.length || heapIndexToAdd < 0) throw ArgumentError("Provide correct heap index between 0 and ${heaps.length-1}");

  if (isDivisionMovePerforming()){
    heaps[selectedHeapToDivide] ~/= 2;
    heaps[heapIndexToAdd] += heaps[selectedHeapToDivide];
    stopDivisionMove();
  }
  else {
    heaps[heapIndexToAdd] += getCurrentNumPending();
  }

  queueCurrentIndex = (queueCurrentIndex + 1) % 3;
}

void restart(){
  heaps = [1, 2, 3];
  queueCurrentIndex = 0;
  selectedHeapToDivide = -1;
  isUserFirst = randomNumberGenerator.nextBool();
}

void stopDivisionMove(){
  selectedHeapToDivide = -1;
}

bool isDivisionMovePerforming() => selectedHeapToDivide != -1;


