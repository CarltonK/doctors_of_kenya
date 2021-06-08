import 'package:doctors_of_kenya/widgets/data_retrieval/concierge_data_retrieval.dart';
import 'package:flutter/material.dart';

class MedicalLiaison extends StatelessWidget {
  final String type = 'liason';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ConciergeRetrieval(type: type),
    );
  }
}
