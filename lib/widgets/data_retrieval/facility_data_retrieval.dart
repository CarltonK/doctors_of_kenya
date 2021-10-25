import 'package:doctors_of_kenya/models/models.dart';
import 'package:doctors_of_kenya/providers/providers.dart';
import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FacilityRetrieval extends StatefulWidget {
  final String type;
  FacilityRetrieval({Key? key, required this.type}) : super(key: key);

  @override
  _FacilityRetrievalState createState() => _FacilityRetrievalState();
}

class _FacilityRetrievalState extends State<FacilityRetrieval> {
  Future? retrieveFacilities;

  @override
  void initState() {
    retrieveFacilities =
        context.read<DatabaseProvider>().retrieveFacilities(widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: retrieveFacilities,
      builder: (context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return GlobalLoader();

          case ConnectionState.active:

          case ConnectionState.none:
            return GlobalErrorContained(
              errorMessage: '${snapshot.error.toString()}',
            );

          case ConnectionState.done:
            if (snapshot.data != null) {
              if (snapshot.data.length == 0) {
                String insertion = widget.type + ' facilities';
                return GlobalErrorContained(
                  errorMessage: 'There are no $insertion available',
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  FacilityModel facilityModel = snapshot.data[index];
                  return FacilityListItem(facilityModel: facilityModel);
                },
              );
            }
            return GlobalErrorContained(
              errorMessage: '${snapshot.error.toString()}',
            );
        }
        // return GlobalLoader();
      },
    );
  }
}

class FacilityListItem extends StatelessWidget {
  final FacilityModel facilityModel;
  FacilityListItem({Key? key, required this.facilityModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String used = facilityModel.paymentModalities.join(', ');
    return Container(
      decoration: Constants.kBoxDecorationStyle,
      child: ListTile(
        leading: Icon(
          Icons.business_outlined,
          color: Theme.of(context).accentColor,
        ),
        title: Text(facilityModel.name!, style: Constants.miniheadlineStyle),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.phone, color: Theme.of(context).accentColor),
                const SizedBox(width: 10),
                Text(
                  facilityModel.contacts!,
                  style: Constants.subheadlineStyle,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.place, color: Theme.of(context).accentColor),
                const SizedBox(width: 10),
                Text(
                  facilityModel.location!,
                  style: Constants.subheadlineStyle,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.money, color: Theme.of(context).accentColor),
                const SizedBox(width: 10),
                Text(
                  'Payment methods accepted are $used',
                  style: Constants.subheadlineStyle,
                ),
              ],
            ),
          ],
        ),
        onTap: () => print('I want to see more about this facility'),
      ),
    );
  }
}
