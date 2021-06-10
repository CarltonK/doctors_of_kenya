import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ContractEmploymentScreen extends StatelessWidget {
  final String type = 'contract';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: OpportunityRetrieval(employmentType: type),
    );
  }
}
