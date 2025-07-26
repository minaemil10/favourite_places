import 'package:flutter/material.dart';

import 'package:favourite_places/models/fav_place.dart';

class FavPlaceEntry extends StatelessWidget {
  const FavPlaceEntry({
    super.key,
    required this.place,
    required this.openPlace,
  });
  final FavPlace place;
  final Function() openPlace;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 26,
          backgroundImage: FileImage(place.image),
        ),
        title: Text(
          place.title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          place.location.address,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        onTap: openPlace,
      ),
    );
  }
}
