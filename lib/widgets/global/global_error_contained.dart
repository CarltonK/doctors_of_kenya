import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class GlobalErrorContained extends StatelessWidget {
  final String errorMessage;

  GlobalErrorContained({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: GlobalInfoDialog(
          message: errorMessage,
        ),
      ),
    );
  }
}
