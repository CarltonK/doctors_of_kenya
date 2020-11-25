import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class JobPostCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => print("I want to view this job"),
        leading: CircleButton(
          icon: Icons.arrow_forward_ios,
          iconSize: 30,
          color: Colors.black.withOpacity(0.5),
          onPressed: null,
        ),
        title: Text(
          "Surgeon",
          style: Theme.of(context).textTheme.headline4,
        ),
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 6,
            ),
            Text(
              "Kenyatta Hospital",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              "Ksh 300 - 400K",
              // style: Theme.of(context).textTheme.subtitle1,
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
              onPressed: () => print("I want to bookmark this job"),
            )
          ],
        ),
      ),
    );
  }
}
