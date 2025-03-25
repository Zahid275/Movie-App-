import 'package:flutter/material.dart';

class WL_Model {
  final Map<String, dynamic> movieData;
  final void Function()? onTap;
  final void Function()? onLongPress;
  Color color;

  WL_Model(
      {required this.movieData,
      required this.onLongPress,
      required this.onTap,
      required this.color});
}
