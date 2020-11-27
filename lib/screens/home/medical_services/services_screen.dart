import 'package:doctors_of_kenya/screens/home/medical_services/services.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  Widget _tabHeaders() {
    return TabBar(
      isScrollable: true,
      tabs: [
        TabWidget(title: 'Preventive'),
        TabWidget(title: 'Diagnostic'),
        TabWidget(title: 'Therapeutic'),
        TabWidget(title: 'Rehabilitative'),
        TabWidget(title: 'Wellness'),
      ],
    );
  }

  final List<Widget> _pages = [
    PreventiveServices(),
    DiagnosticServices(),
    TherapeuticServices(),
    RehabiilitativeServices(),
    WellnessServices(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: Text(
            'Medical Services',
            style: Theme.of(context).textTheme.headline3,
          ),
          actions: [
            CircleButton(
              icon: CupertinoIcons.search,
              onPressed: () => print('Search'),
              tooltip: 'Search',
            ),
          ],
          bottom: _tabHeaders(),
        ),
        body: TabBarView(
          children: _pages,
        ),
      ),
    );
  }
}
