import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DentistScreen extends StatelessWidget {
  final String type = 'Dentist';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PractitionerRetrieval(type: type),
    );
  }
}
