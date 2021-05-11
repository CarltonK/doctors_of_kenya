import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PrivateFacilities extends StatelessWidget {
  final String type = 'private';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FacilityRetrieval(type: type),
    );
  }
}
