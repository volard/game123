import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:game123/components/pending_number_card.dart';
import '../controllers/elements_controllers.dart';
import '../game/game_logic.dart';

CarouselSlider queueSlider() => CarouselSlider(
      disableGesture: false,
      options: CarouselOptions(
          height: 50,
          scrollPhysics: const NeverScrollableScrollPhysics()
      ),
      carouselController: customCarouselController,
      items: numQueue.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Center(
              child: numberCard(i),
            );
          },
        );
      }).toList(),
    );
