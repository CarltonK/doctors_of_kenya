import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TherapeuticServices extends StatelessWidget {
  final String type = 'therapeutic';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ServiceRetrieval(type: type),
    );
  }
}
