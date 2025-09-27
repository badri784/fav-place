import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fav_place/model/model.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:sqflite/sqflite.dart' as sql;

Future<sql.Database> openbase() async {
  final dbpath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbpath, 'place.db'),
    onCreate: (db, version) => db.execute(
      'CREATE TABLE user_place(id TEXT PRIMARY KEY,title TEXT, image TEXT,lat REAL , lng REAL)',
    ),
    version: 1,
  );
  return db;
}

class AddNewitem extends StateNotifier<List<Model>> {
  AddNewitem() : super([]);
  Future<void> loaddatabase() async {
    final sql.Database db = await openbase();
    final List<Map<String, Object?>> data = await db.query('user_place');
    final place = data
        .map(
          (e) => Model(
            id: e['id'] as String,
            title: e['title'] as String,
            image: File(e['image'] as String),
            locationPlace: LocationPlace(
              latitude: e['lat'] as double,
              lngtiude: e['lng'] as double,
            ),
          ),
        )
        .toList();
    log('load database ${data.toString()}');
    state = place;
  }

  void addnewitem(String title, File image, LocationPlace location) async {
    final appdir = await syspath.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copidimage = await image.copy('${appdir.path}/$filename');
    final newplace = Model(
      title: title,
      image: copidimage,
      locationPlace: location,
    );
    final db = await openbase();
    await db.insert('user_place', {
      'id': newplace.id,
      'title': newplace.title,
      'image': newplace.image.path,
      'lat': newplace.locationPlace.latitude,
      'lng': newplace.locationPlace.lngtiude,
    });
    state = [newplace, ...state];
    log(' db s${db.toString()}');
  }

  Future<void> remove(String id) async {
    final db = await openbase();
    await db.delete('user_place', where: 'id = ?', whereArgs: [id]);
    state = state.where((item) => item.id != id).toList();
  }
}

// provider
final addNewItemProvider = StateNotifierProvider<AddNewitem, List<Model>>(
  (_) => AddNewitem(),
);
