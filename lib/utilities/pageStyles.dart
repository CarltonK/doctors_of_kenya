import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

EdgeInsets layoutPadding(BuildContext context) {
  return Responsive.isDesktop(context)
      ? const EdgeInsets.symmetric(horizontal: 300)
      : const EdgeInsets.symmetric(horizontal: 16);
}
