import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class WellnessServices extends StatelessWidget {
  final String type = 'wellness';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ServiceRetrieval(type: type),
    );
  }
}
