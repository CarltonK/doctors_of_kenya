import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:flutter/material.dart';

class StoreItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  color: Theme.of(context).accentColor.withOpacity(0.5),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Scapel',
                    style: Constants.subheadlineStyle,
                  ),
                  Divider(
                    color: Theme.of(context).accentColor,
                  ),
                  Text(
                    '500 KES',
                    style: Constants.miniheadlineStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
