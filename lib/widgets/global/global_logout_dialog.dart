import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogOutDialog extends StatelessWidget {
  final Function yesClick;
  const LogOutDialog({
    Key key,
    @required this.yesClick,
  }) : assert(yesClick != null);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        'EXIT',
        style: Constants.boldHeadlineStyle,
      ),
      content: Text(
        'Are you sure ? ',
        style: Constants.miniheadlineStyle,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'NO',
            style: Constants.kNegativeButtonStyle,
          ),
        ),
        TextButton(
          onPressed: () {
            // Pop the dialog first
            Navigator.of(context).pop();
            // Perform the action
            yesClick();
          },
          child: Text(
            'YES',
            style: Constants.kPositiveButtonStyle,
          ),
        )
      ],
    );
  }
}
