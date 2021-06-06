import 'package:flutter/material.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';

class AttireStore extends StatelessWidget {
  final String type = 'attire';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StoreRetrieval(type: type),
    );
  }
}
