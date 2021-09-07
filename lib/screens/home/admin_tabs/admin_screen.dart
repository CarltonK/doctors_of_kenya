import 'package:doctors_of_kenya/screens/home/admin_tabs/admin_tabs.dart';
import 'package:doctors_of_kenya/utilities/constants.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  AdminScreen({Key? key}) : super(key: key);

  _tabHeaders() {
    return TabBar(
      tabs: [
        TabWidget(title: 'Practitioners'),
        TabWidget(title: 'Services'),
        TabWidget(title: 'Facilities'),
        TabWidget(title: 'Concierge'),
        TabWidget(title: 'Store'),
        TabWidget(title: 'Resources'),
        TabWidget(title: 'Opportunities'),
      ],
      isScrollable: true,
    );
  }

  final List<Widget> _pages = [
    AdminPractitioners(),
    AdminServices(),
    AdminFacilities(),
    AdminConcierge(),
    AdminStore(),
    AdminResources(),
    AdminOpportunities()
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: Text(
            'Admin Panel',
            style: Constants.headlineWhite,
          ),
          bottom: _tabHeaders(),
        ),
        body: TabBarView(children: _pages),
      ),
    );
  }
}
