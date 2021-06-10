import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PermanentEmploymentScreen extends StatelessWidget {
  final String type = 'permanent';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: OpportunityRetrieval(employmentType: type),
    );
  }
}
