import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:flutter/material.dart';

class ResourceScreen extends StatelessWidget {
  const ResourceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).accentColor,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size.infinite,
                    painter: ProfileCardPainter(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Resource Headline',
                          style: Constants.headlineWhite,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Summary of resource information',
                          style: Constants.subtitleWhite,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'This is an article. Info Info info ' * 5,
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
