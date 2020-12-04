import 'package:doctors_of_kenya/screens/home/medical_store/store.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  Widget _tabHeaders() {
    return TabBar(
      tabs: [
        TabWidget(title: 'Equipment'),
        TabWidget(title: 'Attire'),
        TabWidget(title: 'Perishables'),
      ],
    );
  }

  final List<Widget> _pages = [
    EquipmentStore(),
    AttireStore(),
    PerishablesStore(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: Text(
            'Medical Store',
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
