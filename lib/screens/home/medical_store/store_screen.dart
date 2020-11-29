import 'package:doctors_of_kenya/models/models.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'Medical Store',
          style: Theme.of(context).textTheme.headline3,
        ),
        actions: [
          CircleButton(
            icon: CupertinoIcons.search,
            onPressed: () => print('Search'),
            tooltip: 'Search',
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Container(
            height: 130,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 10.0),
              scrollDirection: Axis.horizontal,
              itemCount: storeModels.length,
              itemBuilder: (context, index) {
                StoreModel _singleModel = storeModels[index];
                return CategoryItem(
                  storeModel: _singleModel,
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
