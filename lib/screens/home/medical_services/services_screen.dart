import 'package:doctors_of_kenya/screens/home/medical_services/services.dart';
import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  Widget _tabHeaders() {
    return TabBar(
      isScrollable: true,
      tabs: [
        TabWidget(title: 'Wellness'),
        TabWidget(title: 'Preventive'),
        TabWidget(title: 'Diagnostic'),
        TabWidget(title: 'Therapeutic'),
        TabWidget(title: 'Rehabilitative'),
      ],
    );
  }

  final List<Widget> _pages = [
    WellnessServices(),
    PreventiveServices(),
    DiagnosticServices(),
    TherapeuticServices(),
    RehabiilitativeServices(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: Text(
            'Services',
            style: Constants.headlineWhite,
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
