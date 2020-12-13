import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:flutter/material.dart';

class PracticionerScreen extends StatelessWidget {
  static const double avatarRadius = 85;
  static const double titleBottomMargin = (avatarRadius * 2) + 18;

  Widget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).accentColor,
      elevation: 0,
    );
  }

  Widget _pageHeader(BuildContext context) {
    return Stack(
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
                style: Theme.of(context).textTheme.headline2,
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
            backgroundImage: CachedNetworkImageProvider(
              'https://images.unsplash.com/photo-1582750433449-648ed127bb54?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: _pageHeader(context),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'This is a small history about me. I am a doctor. ' * 5,
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
