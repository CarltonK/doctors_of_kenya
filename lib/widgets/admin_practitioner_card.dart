import 'package:doctors_of_kenya/models/models.dart';
import 'package:doctors_of_kenya/providers/providers.dart';
import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminPractionerCard extends StatelessWidget {
  const AdminPractionerCard({Key? key, required this.user}) : super(key: key);

  final UserModel user;

  adminAcceptButtonPressed(BuildContext context) async {
    await context.read<DatabaseProvider>().adminAcceptPractitioner(user.uid!);
  }

  adminRejectButtonPressed(BuildContext context) async {
    await context.read<DatabaseProvider>().adminRejectPractitioner(user.uid!);
  }

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
          '${user.firstName} ${user.lastName}',
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
                  '${user.mpdbRegNumber}',
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
                  '${user.email}',
                  style: Constants.subheadlineStyle,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                TextButton(
                  onPressed: () => adminAcceptButtonPressed(context),
                  child: Text('Accept'),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () => adminRejectButtonPressed(context),
                  child: Text('Decline'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
