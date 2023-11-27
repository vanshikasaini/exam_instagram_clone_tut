// convert 0x?????? or #?????? to Color
import 'package:exam_instagram_clone_tut/extensions/strings/remove_all.dart';
import 'package:flutter/material.dart';

extension AsHtmlColorToColor on String {
  Color htmlColorToColor() => Color(
        int.parse(
          removeAll(['0x', '#']).padLeft(8, 'ff'),
          radix: 16,
        ),
      );
}
