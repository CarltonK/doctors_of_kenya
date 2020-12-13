import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doctors_of_kenya/screens/home/medical_concierge/concierge.dart';

class ConciergeScreen extends StatelessWidget {
  Widget _tabHeaders() {
    return TabBar(
      tabs: [
        TabWidget(title: 'Liasion'),
        TabWidget(title: 'Pharmaceutical'),
        TabWidget(title: 'Equipment'),
      ],
    );
  }

  final List<Widget> _pages = [
    MedicalLiaison(),
    MedicalEquipmentRepresentative(),
    PharmaceuticalRepresentatives(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: Text(
            'Medical Concierge',
            style: Theme.of(context).textTheme.headline3,
          ),
          bottom: _tabHeaders(),
        ),
        body: TabBarView(
          children: _pages,
        ),
      ),
    );
  }
}
