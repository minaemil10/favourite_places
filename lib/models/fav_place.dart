import 'dart:io';

class PlaceLocation {
  PlaceLocation({
    required this.longitude,
    required this.latitude,
    required this.address,
  });

  final double longitude;
  final double latitude;
  final String address;
}

class FavPlace {
  FavPlace({
    required this.id,
    required this.title,
    required this.image,
    required this.location,
  });

  final String id;
  final String title;
  final File image;
  final PlaceLocation location;
}
