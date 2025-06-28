import 'package:flutter/material.dart';

import 'package:favourite_places/models/fav_place.dart';

class FavPlaceDetails extends StatelessWidget {
  const FavPlaceDetails({super.key, required this.place});
  final FavPlace place;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ],
      ),
    );
  }
}
