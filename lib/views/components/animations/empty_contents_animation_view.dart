

import 'package:instanews_app/views/components/animations/lottie_animation_view.dart';
import 'package:instanews_app/views/components/animations/models/lottie_animation.dart';

class EmptyContentsAnimationView extends LottieAnimationView {
  const EmptyContentsAnimationView({super.key})
      : super(
          animation: LottieAnimation.empty,
        );
}
