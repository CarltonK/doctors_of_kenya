import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  static const double avatarRadius = 90;
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
                ListItem(title: 'Medical Practicioners', onTap: null),
                ListItem(title: 'Medical Services', onTap: null),
                ListItem(title: 'Medical Facilities', onTap: null),
                ListItem(title: 'Medical Concierge', onTap: null),
                ListItem(title: 'Medical Store', onTap: null),
                ListItem(title: 'Practicioner Resources', onTap: null),
                ListItem(title: 'Patient Center', onTap: null),
                ListItem(title: 'Employment Opportunities', onTap: null),
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
  final Function onTap;

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
          onTap: onTap,
        ),
        Divider(
          color: Theme.of(context).accentColor.withOpacity(0.5),
          indent: 2,
          endIndent: 2,
        ),
      ],
    );
  }
}
