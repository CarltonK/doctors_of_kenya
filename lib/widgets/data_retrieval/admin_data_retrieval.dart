import 'package:doctors_of_kenya/models/models.dart';
import 'package:doctors_of_kenya/providers/providers.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminPractitionerRetrieval extends StatefulWidget {
  const AdminPractitionerRetrieval({
    Key? key,
    required this.type,
  }) : super(key: key);
  final String type;

  @override
  _AdminPractitionerRetrievalState createState() =>
      _AdminPractitionerRetrievalState();
}

class _AdminPractitionerRetrievalState
    extends State<AdminPractitionerRetrieval> {
  Future? retrievePractitioners;

  @override
  void initState() {
    retrievePractitioners =
        context.read<DatabaseProvider>().retrieveAllPractitioners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: retrievePractitioners,
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
            if (snapshot.data.toString().toLowerCase().contains('permission')) {
              return GlobalErrorContained(
                errorMessage: 'You do not have sufficient permissions',
              );
            }
            if (snapshot.data.length == 0) {
              String insertion = widget.type == 'unspecified'
                  ? 'practitoner'
                  : widget.type == 'non-clinical'
                      ? 'practitoner'
                      : widget.type;
              return GlobalErrorContained(
                errorMessage: 'There are no ${insertion}s available',
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                UserModel user = snapshot.data[index];
                return AdminPractionerCard(user: user);
              },
            );
        }
        // return GlobalLoader();
      },
    );
  }
}
