import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImage extends StatefulWidget {
  const AddImage({super.key, required this.onPickImage});
  final void Function(File image) onPickImage;

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  File? imagefile;

  Future<void> pickimage() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    setState(() {
      imagefile = File(image.path);
    });
    widget.onPickImage(imagefile!);
  }

  Future<void> loadimage() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      imagefile = File(image.path);
    });
    widget.onPickImage(imagefile!);
  }

  Future<void> showdialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('pick your image'),
        content: const Text('please chouse between camera and gallery'),
        actions: [
          Row(
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  loadimage();
                },
                icon: const Icon(Icons.browse_gallery),
                label: const Text('Gallery'),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  pickimage();
                },
                icon: const Icon(Icons.camera_alt_outlined),
                label: const Text('Camera'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Image.asset('assets/image/data.png'),
            const Align(
              alignment: AlignmentGeometry.bottomRight,
              child: Text('add your image'),
            ),
          ],
        ),
      ),
    );
    if (imagefile != null) {
      content = Image.file(imagefile!, fit: BoxFit.cover);
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GestureDetector(
        onTap: () {
          showdialog();
        },
        child: Container(
          height: 250,
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              width: 3,

              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: content,
        ),
      ),
    );
  }
}
