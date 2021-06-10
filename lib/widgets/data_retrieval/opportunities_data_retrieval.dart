import 'package:doctors_of_kenya/providers/providers.dart';
import 'package:doctors_of_kenya/screens/screens.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OpportunityRetrieval extends StatefulWidget {
  final String employmentType;
  OpportunityRetrieval({Key? key, required this.employmentType})
      : super(key: key);

  @override
  _OpportunityRetrievalState createState() => _OpportunityRetrievalState();
}

class _OpportunityRetrievalState extends State<OpportunityRetrieval> {
  Future? retrieveResources;

  @override
  void initState() {
    retrieveResources = context
        .read<DatabaseProvider>()
        .retrieveResources(widget.employmentType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: retrieveResources,
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
            if (snapshot.data.length == 0) {
              String insertion = widget.employmentType == 'unspecified'
                  ? 'practitoner'
                  : widget.employmentType == 'non-clinical'
                      ? 'practitoner'
                      : widget.employmentType;
              return GlobalErrorContained(
                errorMessage: 'There are no ${insertion}s available',
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) => JobPostCard(),
            );
        }
        // return GlobalLoader();
      },
    );
  }
}
