import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: size.width,
              child: DrawerHeader(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text('', style: Theme.of(context).textTheme.headline5),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).accentColor,
                      BlendMode.saturation,
                    ),
                    image: AssetImage("assets/images/dok.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 8),
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
          color: Theme.of(context).accentColor,
          indent: 2,
          endIndent: 2,
        ),
      ],
    );
  }
}
