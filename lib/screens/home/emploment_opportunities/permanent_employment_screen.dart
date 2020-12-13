import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PermanentEmploymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: ListView(
        children: [
          JobPostCard(),
          JobPostCard(),
          JobPostCard(),
          JobPostCard(),
          JobPostCard(),
          JobPostCard(),
          JobPostCard(),
          JobPostCard(),
          JobPostCard(),
          JobPostCard(),
          JobPostCard(),
          JobPostCard(),
        ],
      ),
    );
  }
}
