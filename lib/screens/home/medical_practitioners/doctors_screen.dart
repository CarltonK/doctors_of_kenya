import 'package:doctors_of_kenya/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:provider/provider.dart';

class DoctorsScreen extends StatelessWidget {
  final String type = 'Doctor';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: context.watch<DatabaseProvider>().retrievePractitioners(type),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return GlobalErrorContained(
              errorMessage: '${snapshot.error.toString()}',
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            print(snapshot.data);
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) => PractitionerCard(),
            );
          }

          return GlobalLoader();
        },
      ),
    );
  }
}
