import 'package:doctors_of_kenya/providers/providers.dart';
import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doctors_of_kenya/screens/home/medical_practitioners/practitioners.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  Widget _tabHeaders() {
    return TabBar(
      tabs: [
        TabWidget(title: 'Doctors'),
        TabWidget(title: 'Dentists'),
        TabWidget(title: 'Non-clinical'),
        TabWidget(title: 'Others'),
      ],
      isScrollable: true,
    );
  }

  final List<Widget> _pages = [
    DoctorsScreen(),
    DentistScreen(),
    NonClinicalScreen(),
    OthersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: Text(
            'Practitioners',
            style: Constants.headlineWhite,
          ),
          bottom: _tabHeaders(),
          actions: [
            CircleButton(
              icon: CupertinoIcons.search,
              onPressed: () => showSearch(context: context, delegate: Search()),
              tooltip: 'Search',
            ),
            CircleButton(
              icon: Icons.exit_to_app,
              onPressed: () => dialogExitApp(context, () {
                Provider.of<AuthProvider>(context, listen: false).signOut();
              }),
              tooltip: 'Signout',
            ),
          ],
        ),
        drawerEnableOpenDragGesture: false,
        drawer: AppDrawer(),
        body: TabBarView(
          children: _pages,
        ),
      ),
    );
  }
}

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      CircleButton(
        icon: Icons.clear,
        color: Colors.black,
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return CircleButton(
      icon: Icons.arrow_back_ios,
      color: Colors.black,
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Text(
        query ?? '',
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text(query);
  }
}
