import 'package:flutter/material.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';

class AttireStore extends StatelessWidget {
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
