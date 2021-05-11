import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PublicFacilities extends StatelessWidget {
  final String type = 'public';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FacilityRetrieval(type: type),
    );
  }
}
