import 'package:exam_instagram_clone_tut/views/components/animations/lottie_animation_view.dart';
import 'package:exam_instagram_clone_tut/views/components/animations/models/lottie_animations.dart';

class EmptyContextsAnimationView extends LottieAnimationView {
  const EmptyContextsAnimationView({super.key})
      : super(
          animtion: LottieAnimation.empty,
        );
}
