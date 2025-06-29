import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favourite_places/widgets/pick_image.dart';
import 'package:favourite_places/providers/fav_places_provider.dart';

class AddPlaceForm extends ConsumerStatefulWidget {
  const AddPlaceForm({super.key});

  @override
  ConsumerState<AddPlaceForm> createState() => _AddPlaceFormState();
}

class _AddPlaceFormState extends ConsumerState<AddPlaceForm> {
  final formKey = GlobalKey<FormState>();
  File? image;
  String title = '';

  void onAddPlace() {
    if (formKey.currentState!.validate()) {
      if (image != null) {
        formKey.currentState!.save();
        ref.read(favPlacesProvider.notifier).addPlace(title, image!);
        Navigator.pop(context); // Close the bottom sheet
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Must Pick an image!')));
      }
    }
  }

  void onPickImage(File? img) {
    image = img;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Place')),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  title = value!;
                },
              ),
              const SizedBox(height: 10),
              PickImage(onPick: onPickImage),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: onAddPlace,
                icon: Icon(Icons.add),
                label: Text('Add Place'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
