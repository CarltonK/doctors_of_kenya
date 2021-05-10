import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RehabiilitativeServices extends StatelessWidget {
  final String type = 'rehabilitative';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ServiceRetrieval(type: type),
    );
  }
}
