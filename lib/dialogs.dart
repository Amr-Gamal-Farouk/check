import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

Future<dynamic> showDialogNotInternet(BuildContext context) {
  return showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return ClassicGeneralDialogWidget(
        titleText: "Internet Issue",
        contentText: "Please Checking InterNet Connection",
        actions: [
          FlatButton(
              onPressed: () {
                AppSettings.openWIFISettings();
              },
              child: Text("Setting"))
        ],
      );
    },
    animationType: DialogTransitionType.slideFromTop,
    curve: Curves.fastOutSlowIn,
    duration: Duration(seconds: 1),
  );
}
