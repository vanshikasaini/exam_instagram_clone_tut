import 'package:exam_instagram_clone_tut/views/components/animations/models/lottie_animations.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimationView extends StatelessWidget {
  final LottieAnimation animtion;
  final bool repeat;
  final bool reverse;

  const LottieAnimationView({
    super.key,
    required this.animtion,
    this.repeat = true,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) => Lottie.asset(
        animtion.fullPath,
        repeat: repeat,
        reverse: reverse,
      );
}

extension GetFullPath on LottieAnimation {
  String get fullPath => 'assets/animations/$name.json';
}
