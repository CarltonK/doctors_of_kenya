import 'package:doctors_of_kenya/providers/providers.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FacilityRetrieval extends StatefulWidget {
  final String type;
  FacilityRetrieval({Key key, @required this.type}) : super(key: key);

  @override
  _FacilityRetrievalState createState() => _FacilityRetrievalState();
}

class _FacilityRetrievalState extends State<FacilityRetrieval> {
  Future retrieveFacilities;

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
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return GlobalLoader();

          case ConnectionState.active:

          case ConnectionState.none:
            return GlobalErrorContained(
              errorMessage: '${snapshot.error.toString()}',
            );

          case ConnectionState.done:
            if (snapshot.data.length == 0) {
              String insertion = widget.type + ' facilities';
              return GlobalErrorContained(
                errorMessage: 'There are no $insertion available',
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) => PractitionerCard(),
            );
        }
        return GlobalLoader();
      },
    );
    ;
  }
}
