import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctors_of_kenya/config/palette.dart';
import 'package:flutter/material.dart';

class InstitutionsList extends StatefulWidget {
  @override
  _InstitutionsListState createState() => _InstitutionsListState();
}

class _InstitutionsListState extends State<InstitutionsList> {
  final int _numInstitutions = 2;
  int _currentInstitution = 0;

  final _CategorySelector _hospital = _CategorySelector(
    icon: Icons.local_hospital,
    name: 'Hospitals',
  );

  final _CategorySelector _clinic = _CategorySelector(
    icon: Icons.local_hospital,
    name: 'Clinics',
  );

  List<Widget> _buildSwitcher() {
    List<Widget> list = [];
    for (int i = 0; i < _numInstitutions; i++) {
      list.add(
        i == _currentInstitution
            ? _indicator(true, _hospital)
            : _indicator(false, _clinic),
      );
    }
    return list;
  }

  Widget _indicator(bool isActive, _CategorySelector child) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isActive
              ? Theme.of(context).accentColor.withOpacity(0.3)
              : Colors.grey[100],
          borderRadius: BorderRadius.circular(30),
        ),
        child: child,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey[100],
            ),
            height: 50,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: _buildSwitcher(),
            ),
          ),
          Container(
            height: 200,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 8.0,
              ),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: _InstitutionListCard(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _CategorySelector extends StatelessWidget {
  final String name;
  final IconData icon;

  const _CategorySelector({
    Key key,
    @required this.name,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon),
        const SizedBox(width: 6),
        Text(
          name,
          style: Theme.of(context).textTheme.headline4,
        )
      ],
    );
  }
}

class _InstitutionListCard extends StatelessWidget {
  final String url =
      'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?ixlib=rb-'
      '1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1035&q=80';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: CachedNetworkImage(
            imageUrl: url,
            height: double.infinity,
            width: 130.0,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: double.infinity,
          width: 130,
          decoration: BoxDecoration(
            gradient: Palette.storyGradient,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 4.0,
              )
            ],
          ),
        ),
        Positioned(
          child: Text(
            'Doctor Name',
            style: Theme.of(context).textTheme.bodyText1,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          bottom: 8.0,
          left: 8.0,
          right: 8.0,
        )
      ],
    );
  }
}
