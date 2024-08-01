import 'package:flutter/material.dart';

showErrorSnackBar({required BuildContext context, required String message}) {
  final snackdemo = SnackBar(
    width: 330,
    showCloseIcon: true,
    closeIconColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    content: Text(
      message,
      style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700),
    ),
    backgroundColor: const Color.fromARGB(255, 215, 26, 13),
    elevation: 10,
    behavior: SnackBarBehavior.floating,
    //margin: const EdgeInsets.all(5),
  );
  ScaffoldMessenger.of(context)
      .showSnackBar(snackdemo)
      .closed
      .then((value) => ScaffoldMessenger.of(context).clearSnackBars());
  ;
}
