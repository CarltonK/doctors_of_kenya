import 'package:doctors_of_kenya/models/models.dart';
import 'package:doctors_of_kenya/providers/providers.dart';
import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminFacilityCard extends StatelessWidget {
  const AdminFacilityCard({Key? key, required this.facility}) : super(key: key);

  final FacilityModel facility;

  adminAcceptButtonPressed(BuildContext context) async {
    await context.read<DatabaseProvider>().adminAcceptFacility(facility.docId!);
  }

  adminRejectButtonPressed(BuildContext context) async {
    await context.read<DatabaseProvider>().adminRejectFacility(facility.docId!);
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
          '${facility.name} ',
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
                  '${facility.location!.county}',
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
                  '${facility.contacts!.officeNumber}',
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
