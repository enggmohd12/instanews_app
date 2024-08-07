import 'package:instanews_app/views/components/animations/lottie_animation_view.dart';
import 'package:instanews_app/views/components/animations/models/lottie_animation.dart';

class ErrorContentsAnimationView extends LottieAnimationView {
  const ErrorContentsAnimationView({super.key})
      : super(
          animation: LottieAnimation.error,
          reverse: true,
        );
}
