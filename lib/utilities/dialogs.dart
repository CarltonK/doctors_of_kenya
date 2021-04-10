import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

Future showInfoDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return GlobalDialog(
        title: "Reset Password",
        descriptions: "Your current password will be reset.Proceed",
        text: "Yes",
      );
    },
  );
}
