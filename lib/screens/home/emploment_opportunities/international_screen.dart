import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class InternationalScreen extends StatelessWidget {
  final String type = 'ngo';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: OpportunityRetrieval(employmentType: type),
    );
  }
}
