import 'package:flutter/material.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';

class ContractEmploymentScreen extends StatelessWidget {
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
