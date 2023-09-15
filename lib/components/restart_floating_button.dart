import 'package:flutter/material.dart';
import '../game.dart';

var restartFloatingButton = const FloatingActionButton(
  onPressed: restart,
  heroTag: null,
  child: Icon(Icons.restart_alt),
);