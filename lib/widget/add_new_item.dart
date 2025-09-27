import 'dart:io';

import 'package:fav_place/model/model.dart';
import 'package:fav_place/provider/add_newitem.dart';
import 'package:fav_place/screen/location.dart';
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

  LocationPlace? _locationPlace;

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
      if (image == null || text.isEmpty || _locationPlace == null) return;
      ref
          .read(addNewItemProvider.notifier)
          .addnewitem(text, image!, _locationPlace!);
      widget.passingimage(image);
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Add New Item'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'title :',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                  controller: titleController,
                ),
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
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => FlutterMapScreen(
                          passlocation: (LocationPlace p1) {
                            setState(() {
                              _locationPlace = p1;
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 3,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/image/data_one.png',
                          fit: BoxFit.contain,
                        ),
                        const Align(
                          alignment: AlignmentGeometry.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20, right: 12),
                            child: Text('Add your location'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 7,
                        horizontal: 50,
                      ),
                    ),
                    icon: Icon(
                      Icons.cancel,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    label: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: onsave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 7,
                        horizontal: 50,
                      ),
                    ),
                    icon: Icon(
                      Icons.save,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    label: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
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
