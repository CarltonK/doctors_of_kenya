import 'package:doctors_of_kenya/providers/providers.dart';
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
  Future? retrieveOpportunities;

  @override
  void initState() {
    retrieveOpportunities = context
        .read<DatabaseProvider>()
        .retrieveOpportunities(widget.employmentType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: retrieveOpportunities,
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
              return GlobalErrorContained(
                errorMessage: 'There are no opportunities available',
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
