import 'dart:math';

import 'package:flutter/material.dart';
String high_rating() {
    double min = 4.1;
    double max = 5.0;
    Random random = Random();
    double randomNumber = min + random.nextDouble() * (max - min);

    return randomNumber.toStringAsFixed(1);
  }

  String low_rating() {
    double min = 3.0;
    double max = 4.0;
    Random random = Random();
    double randomNumber = min + random.nextDouble() * (max - min);
    return randomNumber.toStringAsFixed(1);
  }