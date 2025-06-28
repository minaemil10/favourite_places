
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'package:favourite_places/models/fav_place.dart';

const uuid = Uuid();

class FavPlacesNotifier extends StateNotifier<List<FavPlace>> {
  FavPlacesNotifier(super.state);

  void addPlace(String title) {
    final newPlace = FavPlace(id: uuid.v4(), title: title);
    state = [newPlace, ...state];
  }
}

final favPlacesProvider =
    StateNotifierProvider<FavPlacesNotifier, List<FavPlace>>(
      (ref) => FavPlacesNotifier([]),
    );
