import 'package:doctors_of_kenya/screens/screens.dart';
import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:flutter/material.dart';

import 'global/global_circle_button.dart';

class ResourceCard extends StatelessWidget {
  const ResourceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).accentColor,
        ),
        height: 200,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 60,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomRight: Radius.circular(8),
                  ),
                  color: Colors.orange[300],
                ),
                alignment: Alignment.center,
                child: CircleButton(
                  icon: Icons.arrow_forward_sharp,
                  onPressed: () => Navigator.of(context).push(
                    SlideLeftTransition(
                      page: ResourceScreen(),
                    ),
                  ),
                  iconSize: 40,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text('Resource Headline', style: Constants.subHeadlineWhite),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Summary of resource information',
                    style: Constants.subHeadlineWhite,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
