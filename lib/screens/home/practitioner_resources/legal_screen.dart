import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LegalScreen extends StatelessWidget {
  final String type = 'legal';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ResourceRetrieval(resourceType: type),
    );
  }
}
