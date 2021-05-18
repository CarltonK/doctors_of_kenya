import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future showInfoDialog(BuildContext context, String message) {
  return showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: GlobalInfoDialog(message: message),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}

Future dialogExitApp(BuildContext context, Function yesClick) {
  return showCupertinoModalPopup(
    context: context,
    builder: (context) => LogOutDialog(yesClick: yesClick),
  );
}
