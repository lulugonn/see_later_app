import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:see_later_app/screens/loading.dart';

class AlertDialogService {
  AlertDialogService();

  void showLoader(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Loading(
            opacity: 0.3,
          );
        });
  }

  void closeLoader(BuildContext context) {
    Navigator.of(context).pop();
  }

  void showAlertDefault(BuildContext context, title, content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog.adaptive(
          title: Text(title ?? 'Atenção!'),
          content: Text(content ?? 'Ocorreu um erro insperado.'),
          actions: (!kIsWeb)? Platform.isIOS? <Widget>[
            // define os botões na base do dialogo
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            ),
          ]:  [TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            )]:[TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            )],
        );
      },
    );
  }

  
}
