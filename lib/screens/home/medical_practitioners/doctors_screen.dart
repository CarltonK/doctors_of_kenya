import 'package:flutter/material.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';

class DoctorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        children: [
          PractitionerCard(),
          PractitionerCard(),
          PractitionerCard(),
          PractitionerCard(),
        ],
      ),
    );
  }
}
