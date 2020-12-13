import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class EquipmentStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: GridView.count(
        crossAxisCount: 2,
        children: [
          StoreItem(),
          StoreItem(),
          StoreItem(),
          StoreItem(),
        ],
      ),
    );
  }
}
