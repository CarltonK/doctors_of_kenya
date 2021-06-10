import 'package:doctors_of_kenya/providers/providers.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResourceRetrieval extends StatefulWidget {
  final String resourceType;
  ResourceRetrieval({Key? key, required this.resourceType}) : super(key: key);

  @override
  _ResourceRetrievalState createState() => _ResourceRetrievalState();
}

class _ResourceRetrievalState extends State<ResourceRetrieval> {
  Future? retrieveResources;

  @override
  void initState() {
    retrieveResources =
        context.read<DatabaseProvider>().retrieveResources(widget.resourceType);
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
            if (snapshot.data.toString().toLowerCase().contains('permission')) {
              return GlobalErrorContained(
                errorMessage: 'You do not have sufficient permissions',
              );
            }
            if (snapshot.data.length == 0) {
              String insertion = widget.resourceType == 'unspecified'
                  ? 'practitoner'
                  : widget.resourceType == 'non-clinical'
                      ? 'practitoner'
                      : widget.resourceType;
              return GlobalErrorContained(
                errorMessage: 'There are no ${insertion}s available',
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) => ResourceCard(),
            );
        }
        // return GlobalLoader();
      },
    );
  }
}
