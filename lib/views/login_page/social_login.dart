import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialLogin extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isImage;
  final IconData? icon;
  final String? imageLink;
  const SocialLogin(
     {
    super.key,
    required this.isImage,
    required this.onPressed,
    required this.icon,
    required this.imageLink,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(1, 2),
              )
            ]),
        child: isImage
            ? Image.asset(
                imageLink!,
              )
            : FaIcon(
                icon,
                size: 35,
                color: const Color(0xff1877F2),
              ),
      ),
    );
  }
}
