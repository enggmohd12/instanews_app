import 'package:flutter/material.dart';

class RichTwoPartText extends StatelessWidget {
  final String rightPart;
  final String leftPart;
  const RichTwoPartText({
    super.key,
    required this.rightPart,
    required this.leftPart,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          height: 1.5,
          color: Colors.white70,
        ),
        children: [
          TextSpan(
            text: leftPart,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: ' $rightPart',
          )
        ],
      ),
    );
  }
}
