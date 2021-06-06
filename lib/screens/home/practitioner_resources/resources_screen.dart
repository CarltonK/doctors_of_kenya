import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doctors_of_kenya/screens/home/practitioner_resources/resources.dart';

class ResourcesScreen extends StatelessWidget {
  _tabHeaders() {
    return TabBar(
      isScrollable: true,
      tabs: [
        TabWidget(title: 'Legal'),
        TabWidget(title: 'Insurance'),
        TabWidget(title: 'Financial'),
        TabWidget(title: 'Networking'),
        TabWidget(title: 'Education'),
      ],
    );
  }

  final List<Widget> _pages = [
    LegalScreen(),
    InsuranceScreen(),
    FinancialScreen(),
    NetworkingScreen(),
    EducationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: Text(
            'Resources',
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
