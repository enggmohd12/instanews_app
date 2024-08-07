import 'package:instanews_app/views/components/animations/lottie_animation_view.dart';
import 'package:instanews_app/views/components/animations/models/lottie_animation.dart';

class GlobeAnimationView extends LottieAnimationView {
  const GlobeAnimationView({super.key})
      : super(
          animation: LottieAnimation.globe,
        );
}
