import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/likes/provider/like_provider.dart';

class PostDoubleTapClick extends ConsumerWidget {
  const PostDoubleTapClick({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final check = ref.watch(likeclickprovider);
    return check
        ? AnimatedOpacity(
              opacity: check ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 950),
              child: Icon(
                Icons.favorite,
                color: Colors.purpleAccent.shade400,
                size: 100,
              ),
            ) : const SizedBox();
        
  }
}
