import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class InsuranceScreen extends StatelessWidget {
  final String type = 'insurance';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ResourceRetrieval(resourceType: type),
    );
  }
}
