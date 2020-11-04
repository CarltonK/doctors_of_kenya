import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctors_of_kenya/config/palette.dart';
import 'package:flutter/material.dart';

class DoctorsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Doctors',
            style: Theme.of(context).textTheme.headline4,
          ),
          Container(
            height: 200,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 8.0,
              ),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: _DoctorListCard(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _DoctorListCard extends StatelessWidget {
  final String url =
      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb'
      '-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: CachedNetworkImage(
            imageUrl: url,
            height: double.infinity,
            width: 110.0,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: double.infinity,
          width: 110,
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
