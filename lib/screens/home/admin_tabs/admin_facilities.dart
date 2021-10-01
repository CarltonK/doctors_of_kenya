import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AdminFacilities extends StatelessWidget {
  const AdminFacilities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AdminFacilityRetrieval(),
    );
  }
}
