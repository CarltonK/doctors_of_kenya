import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NonClinicalScreen extends StatelessWidget {
  final String type = 'Non-clinical';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PractitionerRetrieval(type: type),
    );
  }
}
