import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: Container(),
    );
  }
}
