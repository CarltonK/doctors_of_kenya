import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TrackingScrollController _trackingScrollController;

  @override
  void initState() {
    _trackingScrollController = TrackingScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: CustomScrollView(
          controller: _trackingScrollController,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16.0, 50.0, 8.0, 10.0),
              sliver: SliverToBoxAdapter(
                child: AppBar(),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 0.0),
              sliver: SliverToBoxAdapter(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  final String url =
      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: url,
                    height: 55,
                    width: 55,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'James Dean',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          ),
          CircleButton(
            icon: CupertinoIcons.settings,
            iconSize: 35.0,
            onPressed: () => print('Settings'),
            tooltip: 'Settings',
          ),
        ],
      ),
    );
  }
}
