import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class FinancialScreen extends StatelessWidget {
  final String type = 'financial';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ResourceRetrieval(resourceType: type),
    );
  }
}
