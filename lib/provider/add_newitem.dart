import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fav_place/model/model.dart'; /*
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:sqflite/sqflite.dart' as sql;

opendatabase() async {
  final dbpath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbpath, 'place.db'),
    onCreate: (db, version) {
      db.execute(
        'CREATE TABLE user_place(id TEXT PRIMARY KEY,title TEXT,image TEXT,)',
      );
    },
  );
}
*/

class AddNewitem extends StateNotifier<List<Model>> {
  AddNewitem() : super([]);
  void addnewitem(String title, File image, LocationPlace location) {
    final newitem = Model(title: title, image: image, locationPlace: location);
    state = [newitem, ...state];
  }

  void remove(String id) {
    state = state.where((item) => item.id != id).toList();
  }
}

// provider
final addNewItemProvider = StateNotifierProvider<AddNewitem, List<Model>>(
  (_) => AddNewitem(),
);
