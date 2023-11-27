import 'package:exam_instagram_clone_tut/views/components/animations/lottie_animation_view.dart';
import 'package:exam_instagram_clone_tut/views/components/animations/models/lottie_animations.dart';

class LoadingAnimationView extends LottieAnimationView {
  const LoadingAnimationView({super.key})
      : super(
          animtion: LottieAnimation.loading,
        );
}
