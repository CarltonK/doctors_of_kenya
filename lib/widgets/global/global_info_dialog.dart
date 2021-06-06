import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:flutter/material.dart';

class GlobalInfoDialog extends StatelessWidget {
  final String message;
  GlobalInfoDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sentiment_dissatisfied,
            size: 150,
            color: Theme.of(context).accentColor,
          ),
          const SizedBox(height: 5),
          Text(
            message,
            style: Constants.miniheadlineStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
