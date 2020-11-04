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
                child: HomeAppBar(),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
              sliver: SliverToBoxAdapter(
                child: SearchField(),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 0.0),
              sliver: SliverToBoxAdapter(
                child: DoctorsList(),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 0.0),
              sliver: SliverToBoxAdapter(),
            ),
          ],
        ),
      ),
    );
  }
}
