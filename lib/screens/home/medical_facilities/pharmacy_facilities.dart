import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PharmacyFacilities extends StatelessWidget {
  final String type = 'pharmaceutical';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FacilityRetrieval(type: type),
    );
  }
}
