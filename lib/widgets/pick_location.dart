import 'dart:convert';

import 'package:favourite_places/models/fav_place.dart';
import 'package:favourite_places/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class PickLocation extends StatefulWidget {
  const PickLocation({super.key, required this.onSelectLocation});
  final Function(PlaceLocation) onSelectLocation;
  @override
  State<PickLocation> createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  PlaceLocation? chosenLocation;
  bool isChoosingLocation = false;

  String get locationImageURL {
    if (chosenLocation == null) {
      return '';
    }
    final lat = chosenLocation!.latitude;
    final lng = chosenLocation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=14&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C$lat,$lng&key=AIzaSyAWn2RgxY6qXV967TqpejoGqA9Xt1mtuY4';
  }

  void savePlace(double? latitude, double? longitude) async {
    var url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyAWn2RgxY6qXV967TqpejoGqA9Xt1mtuY4',
    );
    if (latitude == null || longitude == null) {
      return;
    }
    var response = await http.get(url);
    var decodedResponse = json.decode(response.body);
    var address = decodedResponse['results'][0]['formatted_address'];

    setState(() {
      isChoosingLocation = false;
      chosenLocation = PlaceLocation(
        longitude: longitude,
        latitude: latitude,
        address: address,
      );
      widget.onSelectLocation(chosenLocation!);
    });
  }

  void getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      isChoosingLocation = true;
    });

    locationData = await location.getLocation();
    var lat = locationData.latitude;
    var lng = locationData.longitude;
    savePlace(lat, lng);
  }

  void chooseLocation() async {
    final location = await Navigator.of(
      context,
    ).push<LatLng?>(MaterialPageRoute(builder: (ctx) => MapScreen()));
    if (location == null) {
      return;
    }
    savePlace(location.latitude, location.longitude);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Text(
      'No Location Picked Yet!',
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
    if (isChoosingLocation) {
      content = CircularProgressIndicator();
    }
    if (chosenLocation != null) {
      content = Image.network(locationImageURL, fit: BoxFit.cover);
    }
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(
                context,
              ).colorScheme.primary.withAlpha((0.2 * 255).toInt()),
            ),
          ),
          child: content,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: getCurrentLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
            ),
            TextButton.icon(
              onPressed: chooseLocation,
              icon: Icon(Icons.map),
              label: Text('choose Location'),
            ),
          ],
        ),
      ],
    );
  }
}
