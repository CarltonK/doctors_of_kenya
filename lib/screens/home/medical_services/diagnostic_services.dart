import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DiagnosticServices extends StatelessWidget {
  final String type = 'diagnostic';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ServiceRetrieval(type: type),
    );
  }
}
