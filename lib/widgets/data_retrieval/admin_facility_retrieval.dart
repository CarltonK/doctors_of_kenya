import 'package:doctors_of_kenya/models/models.dart';
import 'package:doctors_of_kenya/providers/providers.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminFacilityRetrieval extends StatefulWidget {
  const AdminFacilityRetrieval({
    Key? key,
  }) : super(key: key);

  @override
  _AdminFacilityRetrievalState createState() => _AdminFacilityRetrievalState();
}

class _AdminFacilityRetrievalState extends State<AdminFacilityRetrieval> {
  Future? retrieveFacilities;
  @override
  void initState() {
    retrieveFacilities =
        context.read<DatabaseProvider>().adminRetrieveFacilities();
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
                return GlobalErrorContained(
                  errorMessage: 'There are no facilities available',
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  FacilityModel facilityModel = snapshot.data[index];
                  return AdminFacilityCard(facility: facilityModel);
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
