import 'package:flutter/material.dart';

Future<bool> showCustomDialog(BuildContext context, Widget content) async {
  bool isDone = true;
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding: EdgeInsets.zero,
          content: Container(
              width: MediaQuery.of(context).size.width * 0.8, child: content),
        );
      });
  return isDone;
}
