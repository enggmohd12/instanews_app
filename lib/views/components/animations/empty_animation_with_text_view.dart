import 'package:flutter/material.dart';
import 'package:instanews_app/views/components/animations/empty_contents_animation_view.dart';

class EmptyContentsWithTextView extends StatelessWidget {
  final String text;
  const EmptyContentsWithTextView({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white54,
                  ),
            ),
          ),
          const EmptyContentsAnimationView()
        ],
      ),
    );
  }
}
