import 'package:flutter/material.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';

class PerishablesStore extends StatelessWidget {
  final String type = 'perishable';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StoreRetrieval(type: type),
    );
  }
}
