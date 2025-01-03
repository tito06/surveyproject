import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geodesy/geodesy.dart';
import 'package:geolocator/geolocator.dart';

import 'package:area_polygon/area_polygon.dart';

class LocationTrackingScreen extends StatefulWidget {
  @override
  _LocationTrackingScreenState createState() => _LocationTrackingScreenState();
}

class _LocationTrackingScreenState extends State<LocationTrackingScreen> {
  Position? _currentPosition;
  double _distance = 0.0;
  double _area = 0.0;
  List<Map<String, dynamic>> _coordinates = [];
  List<Map<String, dynamic>> _coordinatesTest = [];

  final int _maxCoordinates = 4;

  double earthRadius = 6371000.0;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        _currentPosition = position;
      });
    });
  }

  void _addCoordinates() {
    if (_currentPosition == null) return;

    final latitude = _currentPosition!.latitude;
    final longitude = _currentPosition!.longitude;

    double distance = 0.0;
    if (_coordinates.isNotEmpty) {
      final last = _coordinates.last;
      distance = Geolocator.distanceBetween(
        last['latitude'],
        last['longitude'],
        latitude,
        longitude,
      );
    }

    if (_coordinates.length < _maxCoordinates) {
      setState(() {
        _coordinates.add({
          'latitude': latitude,
          'longitude': longitude,
          'distance': distance.toStringAsFixed(2),
        });
      });

      List<Map<String, dynamic>> manualCoordinates = [
        {'latitude': 26.532582, 'longitude': 88.6796994}, // Point 1
        {'latitude': 26.5323712, 'longitude': 88.6796012}, // Point 2
        {'latitude': 26.5321558, 'longitude': 88.6797383}, // Point 3
        {'latitude': 26.53219, 'longitude': 88.6797918}, // Point 4
      ];

      setState(() {
        _coordinatesTest = manualCoordinates;
      });

      if (_coordinates.length == _maxCoordinates) {
        //  _calculateArea();
        // List<LatLng> points = _coordinates
        //     .map((coord) => LatLng(coord['latitude'], coord['longitude']))
        //     .toList();

        List<List<double>> points = manualCoordinates.map((coord) {
          return [coord['latitude'] as double, coord['longitude'] as double];
        }).toList();

        try {
          //double area = calculatePolygonArea(points);
          double area = calculateGeodesicArea(points);

          // double area = calculateArea(point);

          double areaInHectares = area / 10000;
          //double areaInHectares = 10000;

          print("Calculated Area: $area sq m");
          setState(() {
            _area = areaInHectares;
            print('Area of the quadrilateral: $_area hectre');
          });
        } catch (e) {
          print("Error: $e");
        }
      }
    }
  }

  double calculateGeodesicArea(List<List<double>> points) {
    int n = points.length;
    double area = 0.0;

    for (int i = 0; i < n; i++) {
      int j = (i + 1) % n;

      // Convert latitude and longitude to radians
      double lat1 = points[i][0] * pi / 180;
      double lon1 = points[i][1] * pi / 180;
      double lat2 = points[j][0] * pi / 180;
      double lon2 = points[j][1] * pi / 180;

      // Shoelace formula in spherical coordinates
      area += (lon2 - lon1) * (2 + sin(lat1) + sin(lat2));
    }

    // Final area calculation (absolute value)
    area = area.abs() * earthRadius * earthRadius / 2.0;
    return area; // Area in square meters
  }

  void _resetTracking() {
    setState(() {
      _coordinates.clear();
      _distance = 0.0;
      _area = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Location Tracker"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                if (_currentPosition != null)
                  Center(
                    child: Icon(Icons.location_on, size: 40, color: Colors.red),
                  ),
                Center(
                  child: Text(
                    _currentPosition == null
                        ? "Fetching location..."
                        : "Lat: ${_currentPosition!.latitude.toStringAsFixed(5)}, "
                            "Lng: ${_currentPosition!.longitude.toStringAsFixed(5)}",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: "Distance",
                      hintText: "${_distance.toStringAsFixed(2)} m",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    enabled: true,
                    decoration: InputDecoration(
                      labelText: "Area",
                      hintText: _area == 0
                          ? "..."
                          : "${_area.toStringAsFixed(5)} sq. meters",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          (_coordinates.length >= 4)
              ? ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                        context, {"coordinate": _coordinates, "area": _area});
                  },
                  child: Text("Done"),
                )
              : ElevatedButton(
                  onPressed: _addCoordinates,
                  child: Text("Add Coordinates"),
                ),
          ElevatedButton(
            onPressed: _resetTracking,
            child: Text("Reset"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _coordinates.length,
              itemBuilder: (context, index) {
                final coord = _coordinates[index];
                return Card(
                  child: ListTile(
                    title: Text(
                        "Lat: ${coord['latitude']}, Lng: ${coord['longitude']}"),
                    subtitle: Text("Distance: ${coord['distance']} m"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
