import 'dart:developer';
import 'dart:io';

import 'package:fav_place/provider/add_newitem.dart';
import 'package:fav_place/widget/add_new_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Homescreen extends ConsumerStatefulWidget {
  const Homescreen({super.key});

  @override
  ConsumerState<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends ConsumerState<Homescreen> {
  File? image;
  @override
  Widget build(BuildContext context) {
    final item = ref.watch(addNewItemProvider);
    log(item.length.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('My favorite places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AddNewItem(
                    passingimage: (File? p1) {
                      setState(() {
                        image = p1;
                      });
                    },
                  ),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: item.length,
        itemBuilder: (BuildContext context, index) => Dismissible(
          key: ValueKey(item[index].id),
          background: Container(
            color: Colors.red,
            child: const Icon(Icons.delete),
          ),

          onDismissed: (direction) =>
              ref.watch(addNewItemProvider.notifier).remove(item[index].id),

          child: Card.outlined(
            child: ListTile(
              title: Text(item[index].title),
              leading: CircleAvatar(
                radius: 22,
                backgroundImage: FileImage(item[index].image),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
