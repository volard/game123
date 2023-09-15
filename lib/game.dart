import 'dart:math';

List<int> heaps = [1, 2, 3];

final List<int> numQueue = [3, 1, 2];
int queueCurrentIndex = 0;
int getCurrentNumPending() => numQueue[queueCurrentIndex];
final randomNumberGenerator = Random();
bool isUserFirst = randomNumberGenerator.nextBool();

void makeMove(int heapIndexToAdd, [int? heapIndexToHalve]){
  if (heapIndexToAdd >= heaps.length || heapIndexToAdd < 0) throw ArgumentError("Provide correct heap index between 0 and ${heaps.length-1}");

  if (heapIndexToHalve != null){
    if (heapIndexToHalve >= heaps.length || heapIndexToHalve < 0) throw ArgumentError("Provide correct heap index between 0 and ${heaps.length-1}");

    heaps[heapIndexToHalve] ~/= 2;
    heaps[heapIndexToAdd] += heaps[heapIndexToHalve];
  }
  else {
    heaps[heapIndexToAdd] += getCurrentNumPending();
  }

  queueCurrentIndex = (queueCurrentIndex + 1) % 3;
}

void restart(){
  heaps = [1, 2, 3];
  queueCurrentIndex = 0;
  isUserFirst = randomNumberGenerator.nextBool();
}


