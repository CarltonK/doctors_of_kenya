import 'package:flutter/material.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';

class DoctorsScreen extends StatelessWidget {
  final String type = 'Doctor';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PractitionerRetrieval(type: type),
    );
  }
}
