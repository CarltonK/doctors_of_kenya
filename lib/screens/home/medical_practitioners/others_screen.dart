import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class OthersScreen extends StatelessWidget {
  final String type = 'unspecified';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PractitionerRetrieval(type: type),
    );
  }
}
