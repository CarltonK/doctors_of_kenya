import 'package:doctors_of_kenya/providers/providers.dart';
import 'package:doctors_of_kenya/screens/home/home.dart';
import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  static const double avatarRadius = 85;
  static const double titleBottomMargin = (avatarRadius * 2) + 18;

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String? uid;
  Future? myDocument;

  @override
  void initState() {
    uid = context.read<AuthProvider>().currentUser!.uid;
    myDocument =
        context.read<DatabaseProvider>().retrieveSignInUsersDocument(uid!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: FutureBuilder(
                future: myDocument,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return GlobalLoader();
                    case ConnectionState.active:
                    case ConnectionState.none:
                      return Center(
                        child: GlobalErrorContained(errorMessage: 'Public'),
                      );
                    case ConnectionState.done:
                      if (snapshot.data != null) {
                        return DrawerHeader();
                      }
                      return Center(
                        child: GlobalErrorContained(errorMessage: 'Public'),
                      );
                  }
                }),
          ),
          Expanded(
            flex: 2,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              children: [
                ListItem(title: 'Practitioners', onTap: () {}),
                ListItem(
                  title: 'Services',
                  onTap: () {
                    Navigator.of(context).push(
                      SlideLeftTransition(
                        page: ServicesScreen(),
                      ),
                    );
                  },
                ),
                ListItem(
                  title: 'Facilities',
                  onTap: () {
                    Navigator.of(context).push(
                      SlideLeftTransition(
                        page: FacilitiesScreen(),
                      ),
                    );
                  },
                ),
                // ListItem(
                //   title: 'Concierge',
                //   onTap: () {
                //     Navigator.of(context).push(
                //       SlideLeftTransition(
                //         page: ConciergeScreen(),
                //       ),
                //     );
                //   },
                // ),
                ListItem(
                  title: 'Store',
                  onTap: () {
                    Navigator.of(context).push(
                      SlideLeftTransition(
                        page: StoreScreen(),
                      ),
                    );
                  },
                ),
                ListItem(
                  title: 'Resources',
                  onTap: () {
                    Navigator.of(context).push(
                      SlideLeftTransition(
                        page: ResourcesScreen(),
                      ),
                    );
                  },
                ),
                // ListItem(
                //     title: 'Patient Center',
                //     onTap: () {
                //       Navigator.of(context).push(
                //         SlideLeftTransition(
                //           page: PatientCenterScreen(),
                //         ),
                //       );
                //     }),
                ListItem(
                  title: 'Opportunities',
                  onTap: () {
                    Navigator.of(context).push(
                      SlideLeftTransition(
                        page: EmploymentScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerHeader extends StatelessWidget {
  const DrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: Size.infinite,
          painter: ProfileCardPainter(
            color: Theme.of(context).accentColor,
            avatarRadius: AppDrawer.avatarRadius,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: AppDrawer.titleBottomMargin,
          child: Column(
            children: <Widget>[
              Text(
                'Wayne Rooney',
                style: Constants.headlineWhite,
              ),
              const SizedBox(height: 5),
              Text(
                'Clinical Surgeon',
                style: Constants.subtitleWhite,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: CircleAvatar(
            radius: AppDrawer.avatarRadius,
            backgroundColor: Theme.of(context).accentColor,
            backgroundImage: AssetImage('assets/images/dok.jpg'),
          ),
        ),
      ],
    );
  }
}

class ListItem extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;

  const ListItem({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: Constants.miniheadlineStyle,
          ),
          onTap: () {
            // Pop the drawer before pushing a route
            Navigator.of(context).pop();
            onTap();
          },
        ),
        Divider(
          color: Theme.of(context).accentColor.withOpacity(0.4),
          indent: 2,
          endIndent: 2,
        ),
      ],
    );
  }
}
