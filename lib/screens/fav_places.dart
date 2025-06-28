import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favourite_places/screens/fav_place_details.dart';
import 'package:favourite_places/screens/add_place_form.dart';
import 'package:favourite_places/widgets/fav_place_entry.dart';
import 'package:favourite_places/providers/fav_places_provider.dart';

class FavPlaces extends ConsumerWidget {
  const FavPlaces({super.key});
  // show add place form
  void addPlace(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => AddPlaceForm()));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //get places list
    final places = ref.watch(favPlacesProvider);
    Widget content = Center(
      child: Text(
        'There are no places here, try adding some',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
    if (places.isNotEmpty) {
      content = ListView.builder(
          itemCount: places.length,
          itemBuilder: (BuildContext context, int index) {
            final place = places[index];
            return FavPlaceEntry(
              openPlace: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FavPlaceDetails(place: place),
                  ),
                );
              },
              place: place,
            );
          },
        );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              addPlace(context);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
