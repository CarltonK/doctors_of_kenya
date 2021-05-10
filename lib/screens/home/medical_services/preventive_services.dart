import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PreventiveServices extends StatelessWidget {
  final String type = 'preventive';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ServiceRetrieval(type: type),
    );
  }
}
