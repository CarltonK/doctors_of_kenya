import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctors_of_kenya/screens/home/home.dart';
import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PractitionerCard extends StatelessWidget {
  Widget viewPractitioner(BuildContext context) {
    return Container(
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
            page: PracticionerScreen(),
          ),
        ),
        iconSize: 40,
      ),
    );
  }

  Widget practicionerPhoto(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      margin: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.orange[300],
        image: DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(
            'https://images.unsplash.com/photo-1582750433449-648ed127bb54?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
          ),
        ),
      ),
    );
  }

  Widget practicionerDetails(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dr. Wayne Rooney',
          style: Constants.subHeadlineWhite,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 5,
        ),
        Text('Opthalmologist', style: Constants.subtitleWhite),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }

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
              child: viewPractitioner(context),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  practicionerPhoto(context),
                  const SizedBox(width: 10),
                  Expanded(child: practicionerDetails(context)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
