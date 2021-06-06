import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doctors_of_kenya/providers/providers.dart';

class StoreRetrieval extends StatefulWidget {
  final String type;
  StoreRetrieval({Key? key, required this.type}) : super(key: key);

  @override
  _StoreRetrievalState createState() => _StoreRetrievalState();
}

class _StoreRetrievalState extends State<StoreRetrieval> {
  Future? retrieveStoreItems;

  @override
  void initState() {
    retrieveStoreItems =
        context.read<DatabaseProvider>().retrieveStore(widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: retrieveStoreItems,
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
              String insertion = widget.type + ' items';
              return GlobalErrorContained(
                errorMessage: 'There are no $insertion available',
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return StoreItem();
              },
            );
        }
        // return GlobalLoader();
      },
    );
  }
}

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
