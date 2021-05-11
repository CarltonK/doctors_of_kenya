import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LaboratoryFacilities extends StatelessWidget {
  final String type = 'laboratory';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FacilityRetrieval(type: type),
    );
  }
}
