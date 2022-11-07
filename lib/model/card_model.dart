import 'package:flutter/material.dart';

class CardInfo {
  final String userName;
  final String? cardCategory;
  final Color leftColor;
  final Color rightColor;
  double positionY = 0;
  double rotate = 0;
  double scale = 0;
  double opacity = 0;
  CardInfo({
    required this.userName,
    this.cardCategory,
    required this.leftColor,
    required this.rightColor,
    this.positionY = 0,
    this.rotate = 0,
    this.scale = 0,
    this.opacity = 0,
  });
}
