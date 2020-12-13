import 'package:doctors_of_kenya/screens/home/home.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmploymentScreen extends StatelessWidget {
  Widget _tabHeaders() {
    return TabBar(
      tabs: [
        TabWidget(title: 'Permanent'),
        TabWidget(title: 'Contract'),
      ],
    );
  }

  final List<Widget> _pages = [
    PermanentEmploymentScreen(),
    ContractEmploymentScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: Text(
            'Employment Opportunities',
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
