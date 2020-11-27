import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doctors_of_kenya/screens/home/medical_facilities/facilities.dart';

class FacilitiesScreen extends StatelessWidget {
  Widget _tabHeaders() {
    return TabBar(
      isScrollable: true,
      tabs: [
        TabWidget(title: 'Public'),
        TabWidget(title: 'Private'),
        TabWidget(title: 'Imaging'),
        TabWidget(title: 'Pharmacy'),
        TabWidget(title: 'Laboratory'),
      ],
    );
  }

  final List<Widget> _pages = [
    PublicFacilities(),
    PrivateFacilities(),
    ImagingFacilities(),
    PharmacyFacilities(),
    LaboratoryFacilities(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: Text(
            'Medical Facilities',
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
