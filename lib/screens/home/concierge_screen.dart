import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                "Liasion",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Pharmaceutical",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Equipment",
                style: Theme.of(context).textTheme.headline5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
