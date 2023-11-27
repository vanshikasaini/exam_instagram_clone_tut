import 'package:exam_instagram_clone_tut/views/components/animations/lottie_animation_view.dart';
import 'package:exam_instagram_clone_tut/views/components/animations/models/lottie_animations.dart';

class ErrorAnimationView extends LottieAnimationView {
  const ErrorAnimationView({super.key})
      : super(
          animtion: LottieAnimation.error,
        );
}
