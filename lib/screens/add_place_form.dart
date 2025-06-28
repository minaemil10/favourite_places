import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favourite_places/providers/fav_places_provider.dart';

class AddPlaceForm extends ConsumerWidget {
  const AddPlaceForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    String title = '';

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
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    ref.read(favPlacesProvider.notifier).addPlace(title);
                    Navigator.pop(context); // Close the bottom sheet
                  }
                },
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
