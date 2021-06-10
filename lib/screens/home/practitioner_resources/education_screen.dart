import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class EducationScreen extends StatelessWidget {
  final String type = 'education';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ResourceRetrieval(resourceType: type),
    );
  }
}
