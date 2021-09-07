import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:flutter/material.dart';

class AdminPractitioners extends StatelessWidget {
  const AdminPractitioners({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [AdminPractitionerListItem()],
    );
  }
}

class AdminPractitionerListItem extends StatelessWidget {
  const AdminPractitionerListItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Constants.kBoxDecorationStyle,
      child: ListTile(
        leading: Icon(
          Icons.verified_user_outlined,
          color: Theme.of(context).accentColor,
        ),
        title: Text(
          'Practitioner\'s name',
          style: Constants.miniheadlineStyle,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.add, color: Theme.of(context).accentColor),
                const SizedBox(width: 10),
                Text(
                  'Qualifications(Doctor, dentist...)',
                  style: Constants.subheadlineStyle,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.phone, color: Theme.of(context).accentColor),
                const SizedBox(width: 10),
                Text(
                  '0722356889',
                  style: Constants.subheadlineStyle,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                TextButton(onPressed: () {}, child: Text('Accept')),
                const SizedBox(width: 10),
                TextButton(onPressed: () {}, child: Text('Decline'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
