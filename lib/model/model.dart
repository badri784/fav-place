import 'dart:io';

import 'package:uuid/uuid.dart';

final uuid = const Uuid();

class Model {
  Model({
    String? id,
    required this.title,
    required this.image,
    required this.locationPlace,
  }) : id = id ?? uuid.v4();
  String id;
  String title;
  File image;
  LocationPlace locationPlace;
}

class LocationPlace {
  LocationPlace({required this.latitude, required this.lngtiude});
  double latitude;
  double lngtiude;
}
