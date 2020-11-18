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
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                "Permanent",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Contract",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
