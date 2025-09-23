import 'dart:developer';
import 'dart:io';

import 'package:fav_place/provider/add_newitem.dart';
import 'package:fav_place/widget/add_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNewItem extends ConsumerStatefulWidget {
  const AddNewItem({required this.passingimage, super.key});
  final void Function(File?) passingimage;

  @override
  ConsumerState<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends ConsumerState<AddNewItem> {
  File? image;

  // LocationPlace? _locationPlace;

  TextEditingController titleController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = titleController.text;

    void onsave() {
      log('image = ${image.toString()}');
      if (image == null || text.isEmpty) return;
      ref.read(addNewItemProvider.notifier).addnewitem(text, image!);
      widget.passingimage(image);
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Add New Item'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'title :',
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                controller: titleController,
              ),
              const SizedBox(height: 10),
              AddImage(
                onPickImage: (File pickedimage) {
                  setState(() {
                    image = pickedimage;
                  });
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    icon: const Icon(Icons.cancel),
                    label: const Text('Cancel'),
                  ),
                  ElevatedButton.icon(
                    onPressed: onsave,
                    icon: const Icon(Icons.save),
                    label: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
