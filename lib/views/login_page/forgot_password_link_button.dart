import 'package:flutter/material.dart';

class ForgotLinkButton extends StatelessWidget {
  final String text;
  final  VoidCallback onPressed;
  const ForgotLinkButton({super.key,required this.text,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextButton(
            onPressed: onPressed,
            child: Text(
              text,
              style:const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
