import 'package:exam_instagram_clone_tut/views/components/animations/empty_contents_animation.dart';
import 'package:flutter/material.dart';

class EmptyContentwithTextAnimationView extends StatelessWidget {
  final String text;
  const EmptyContentwithTextAnimationView({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(text,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white54,
                    )),
          ),
          const EmptyContextsAnimationView(),
        ],
      ),
    );
  }
}
