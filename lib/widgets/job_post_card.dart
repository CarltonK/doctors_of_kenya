import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class JobPostCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => print('I want to view this job'),
        title: Text(
          'Surgeon',
          style: Constants.miniheadlineStyle,
        ),
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 6,
            ),
            Text(
              'Kenyatta Hospital',
              style: Constants.subheadlineStyle,
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              'Ksh 300 - 400K',
            )
          ],
        ),
        isThreeLine: true,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleButton(
              icon: Icons.bookmark_border,
              iconSize: 30,
              color: Theme.of(context).accentColor,
              onPressed: () => print('I want to bookmark this job'),
            )
          ],
        ),
      ),
    );
  }
}
