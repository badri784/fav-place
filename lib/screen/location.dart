// import 'dart:developer';
import 'package:fav_place/model/model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class FlutterMapScreen extends StatefulWidget {
  const FlutterMapScreen({super.key, required this.passlocation});
  final void Function(LocationPlace) passlocation;
  @override
  State<FlutterMapScreen> createState() => _FlutterMapScreenState();
}

class _FlutterMapScreenState extends State<FlutterMapScreen> {
  MapController mapController = MapController();

  Future<LocationPlace> getlocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw Exception('Location services disabled');
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw Exception('Location permission not granted');
      }
    }

    locationData = await location.getLocation();

    final locationplace = LocationPlace(
      latitude: locationData.latitude!,
      lngtiude: locationData.longitude!,
    );
    // log(locationplace.latitude.toString());

    widget.passlocation(locationplace);
    return LocationPlace(
      latitude: locationData.latitude!,
      lngtiude: locationData.longitude!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Location'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.save_alt),
          ),
        ],
      ),
      body: FutureBuilder<LocationPlace>(
        future: getlocation(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No location found'));
          }

          final location = snapshot.data!;
          var latLng = LatLng(location.latitude, location.lngtiude);

          return FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialZoom: 13,
              initialCenter: latLng,
              onTap: (tapPosition, point) {
                setState(() {
                  latLng = point;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: latLng,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
              TextSourceAttribution(
                'badri',
                onTap: () => launchUrl(
                  Uri.parse(
                    'https://www.linkedin.com/in/ahmed-elbadri-684178318/',
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
