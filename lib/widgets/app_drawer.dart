import 'package:doctors_of_kenya/screens/home/home.dart';
import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  static const double avatarRadius = 85;
  static const double titleBottomMargin = (avatarRadius * 2) + 18;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                CustomPaint(
                  size: Size.infinite,
                  painter: ProfileCardPainter(
                    color: Theme.of(context).accentColor,
                    avatarRadius: avatarRadius,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: titleBottomMargin,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Wayne Rooney',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Clinical Surgeon',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CircleAvatar(
                    radius: avatarRadius,
                    backgroundColor: Theme.of(context).accentColor,
                    backgroundImage: AssetImage('assets/images/dok.jpg'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              children: [
                ListItem(title: 'Medical Practicioners', onTap: () {}),
                ListItem(
                  title: 'Medical Services',
                  onTap: () {
                    Navigator.of(context).push(
                      SlideLeftTransition(
                        page: ServicesScreen(),
                      ),
                    );
                  },
                ),
                ListItem(
                  title: 'Medical Facilities',
                  onTap: () {
                    Navigator.of(context).push(
                      SlideLeftTransition(
                        page: FacilitiesScreen(),
                      ),
                    );
                  },
                ),
                ListItem(
                  title: 'Medical Concierge',
                  onTap: () {
                    Navigator.of(context).push(
                      SlideLeftTransition(
                        page: ConciergeScreen(),
                      ),
                    );
                  },
                ),
                ListItem(
                  title: 'Medical Store',
                  onTap: () {
                    Navigator.of(context).push(
                      SlideLeftTransition(
                        page: StoreScreen(),
                      ),
                    );
                  },
                ),
                ListItem(
                  title: 'Practicioner Resources',
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
                  title: 'Employment Opportunities',
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

class ListItem extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;

  const ListItem({
    Key key,
    @required this.title,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title ?? '',
            style: Theme.of(context).textTheme.subtitle2,
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
