import 'package:doctors_of_kenya/widgets/data_retrieval/admin_data_retrieval.dart';
import 'package:flutter/material.dart';

class AdminPractitioners extends StatelessWidget {
  final String type = 'doctor';
  const AdminPractitioners({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AdminPractitionerRetrieval(type: type),
    );
  }
}
