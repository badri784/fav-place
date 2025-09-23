import 'dart:io';

import 'package:uuid/uuid.dart';

final uuid = const Uuid();

class Model {
  Model({String? id, required this.title, required this.image})
    : id = id ?? uuid.v4();
  String id;
  String title;
  File image;
}

class LocationPlace {
  LocationPlace({required this.latitude, required this.lngtiude});
  double latitude;
  double lngtiude;
}
