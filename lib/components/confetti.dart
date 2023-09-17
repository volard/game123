import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import '../ui.dart';

ConfettiWidget confetti() => ConfettiWidget(
      blastDirectionality: BlastDirectionality.explosive,
      confettiController: confettiController,
      blastDirection: 120,
      particleDrag: 0.05,
      minBlastForce: 45,
      maxBlastForce: 60,
      emissionFrequency: 0.08,
      numberOfParticles: 25,
      gravity: 0.08,
      shouldLoop: false,
      colors: const [
        Colors.green,
        Colors.red,
        Colors.yellow,
        Colors.blue,
        Colors.black,
        Colors.amber,
        Colors.deepPurpleAccent
      ],
    );
