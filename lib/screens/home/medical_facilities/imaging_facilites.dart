import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ImagingFacilities extends StatelessWidget {
  final String type = 'imaging';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FacilityRetrieval(type: type),
    );
  }
}
