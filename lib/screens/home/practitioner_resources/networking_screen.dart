import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NetworkingScreen extends StatelessWidget {
  final String type = 'networking';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ResourceRetrieval(resourceType: type),
    );
  }
}
