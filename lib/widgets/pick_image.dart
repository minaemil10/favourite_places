import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatefulWidget {
  const PickImage({super.key, required this.onPick});
  final void Function(File? image) onPick;

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File? pickedImage;
  void pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 400,
    );
    if (image == null) {
      return;
    }
    setState(() {
      pickedImage = File(image.path);
      widget.onPick(pickedImage);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      style: TextButton.styleFrom(shape: LinearBorder()),
      onPressed: pickImage,
      icon: Icon(Icons.camera),
      label: Text('Pick An Image'),
    );
    if (pickedImage != null) {
      content = Image.file(
        pickedImage!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      child: content,
    );
  }
}
