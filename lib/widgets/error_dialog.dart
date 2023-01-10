import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void errorDialog(BuildContext context, String errorMsg) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('ERROR'),
          content: Text(errorMsg),
          actions: [
            CupertinoDialogAction(
              child: Text('확인'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  } else {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('ERROR'),
          content: Text(errorMsg),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }
}
