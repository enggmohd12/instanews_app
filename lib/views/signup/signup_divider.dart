import 'package:flutter/material.dart';

class SignUpDivider extends StatelessWidget {
  const SignUpDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Divider(
              color: Colors.black,
              //thickness: 2,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('OR Sign Up with'),
          ),
          Expanded(
            child: Divider(
              color: Colors.black,
              //thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
