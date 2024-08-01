import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginPasswordTextField extends HookWidget {
  final TextInputType type;
  final String hintext;
  final IconData iconData;
  final TextEditingController controller;
  const LoginPasswordTextField({
    super.key,
    required this.hintext,
    required this.iconData,
    required this.controller,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final obscureText = useState(true);
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 12.0,
        top: 12.0,
      ),
      child: TextField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(width: 1, color: Colors.grey.shade400)),
          enabled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(width: 1, color: Colors.grey.shade200),
          ),
          prefixIcon: Icon(
            iconData,
            color: Colors.grey,
          ),
          hintText: hintext,
          hintStyle: const TextStyle(color: Colors.grey),
          fillColor: Colors.grey.shade200,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
          suffixIcon: IconButton(
            icon: Icon(
              obscureText.value ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: () {
              obscureText.value = !obscureText.value;
            },
          ),

        ),
        obscureText: obscureText.value,
      ),
    );
  }
}
