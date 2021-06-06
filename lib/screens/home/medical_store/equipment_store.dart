import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class EquipmentStore extends StatelessWidget {
  final String type = 'equipment';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StoreRetrieval(type: type),
    );
  }
}
