import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

Future showInfoDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return InfoDialog(
        detail: "Your current password will be reset.Proceed",
        buttonPressed: () => print("Button pressed"),
      );
    },
  );
}
