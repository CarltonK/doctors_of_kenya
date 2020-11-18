import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctors_of_kenya/widgets/circle_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  final String url =
      'https://images.unsplash.com/photo-1535745318714-da922ca9cc81?ixlib='
      'rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=967&q=80';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: url,
                    height: 55,
                    width: 55,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'James Dean',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          ),
          CircleButton(
            icon: CupertinoIcons.settings,
            iconSize: 35.0,
            onPressed: () => print('Settings'),
            tooltip: 'Settings',
          ),
        ],
      ),
    );
  }
}
