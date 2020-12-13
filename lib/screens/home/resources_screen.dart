import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResourcesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'Practicioner Resources',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }
}
