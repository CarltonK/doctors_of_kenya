import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  // Widget _firstOption() {
  //   return CustomScrollView(
  //     controller: _trackingScrollController,
  //     slivers: [
  //       SliverPadding(
  //         padding: const EdgeInsets.fromLTRB(16.0, 50.0, 8.0, 10.0),
  //         sliver: SliverToBoxAdapter(
  //           child: HomeAppBar(),
  //         ),
  //       ),
  //       SliverPadding(
  //         padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
  //         sliver: SliverToBoxAdapter(
  //           child: SearchField(),
  //         ),
  //       ),
  //       SliverPadding(
  //         padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 0.0),
  //         sliver: SliverToBoxAdapter(
  //           child: DoctorsList(),
  //         ),
  //       ),
  //       SliverPadding(
  //         padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 0.0),
  //         sliver: SliverToBoxAdapter(
  //           child: InstitutionsList(),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        actions: [
          CircleButton(
            icon: CupertinoIcons.search,
            iconSize: 35.0,
            onPressed: () => print('Search'),
            tooltip: 'Search',
          ),
          CircleButton(
            icon: CupertinoIcons.settings,
            iconSize: 35.0,
            onPressed: () => print('Settings'),
            tooltip: 'Settings',
          ),
        ],
      ),
      drawerEnableOpenDragGesture: false,
      drawer: AppDrawer(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
      ),
    );
  }
}
