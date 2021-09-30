import 'package:doctors_of_kenya/models/models.dart';
import 'package:doctors_of_kenya/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ConciergeRetrieval extends StatefulWidget {
  final String type;
  ConciergeRetrieval({Key? key, required this.type}) : super(key: key);

  @override
  _ConciergeRetrievalState createState() => _ConciergeRetrievalState();
}

class _ConciergeRetrievalState extends State<ConciergeRetrieval> {
  Future? retrieveConcierge;

  @override
  void initState() {
    retrieveConcierge =
        context.read<DatabaseProvider>().retrieveConcierge(widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: retrieveConcierge,
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
                  ? 'liason'
                  : widget.type == 'non-clinical'
                      ? 'liason'
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
                return PractitionerCard(user: user);
              },
            );
        }
        // return GlobalLoader();
      },
    );
  }
}
