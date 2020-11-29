import 'package:doctors_of_kenya/models/models.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final StoreModel storeModel;
  CategoryItem({Key key, @required this.storeModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: storeModel.selected
              ? Theme.of(context).accentColor
              : Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        height: 120,
        width: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(storeModel.image),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              storeModel.title,
              style: Theme.of(context).textTheme.subtitle2,
            )
          ],
        ),
      ),
    );
  }
}
