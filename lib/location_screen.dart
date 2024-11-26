import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geodesy/geodesy.dart';
import 'package:geolocator/geolocator.dart';

class LocationTrackingScreen extends StatefulWidget {
  @override
  _LocationTrackingScreenState createState() => _LocationTrackingScreenState();
}

class _LocationTrackingScreenState extends State<LocationTrackingScreen> {
  Position? _currentPosition;
  double _distance = 0.0;
  double _area = 0.0;
  List<Map<String, dynamic>> _coordinates = [];

  final int _maxCoordinates = 4;

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

      if (_coordinates.length == _maxCoordinates) {
        //  _calculateArea();
        List<LatLng> points = _coordinates
            .map((coord) => LatLng(coord['latitude'], coord['longitude']))
            .toList();

        try {
          double area = calculatePolygonArea(points);
          double areaInHectares = area / 10000;

          print("Calculated Area: $areaInHectares hectre");
          setState(() {
            _area = areaInHectares;
            print('Area of the quadrilateral: $_area hectre');
// Update the area if needed
          });
        } catch (e) {
          print("Error: $e");
        }
      }
    }
  }

  // void _calculateArea() {
  //   if (_coordinates.length < _maxCoordinates) return;

  //   double sum1 = 0.0, sum2 = 0.0;
  //   for (int i = 0; i < _coordinates.length; i++) {
  //     final current = _coordinates[i];
  //     final next = _coordinates[(i + 1) % _maxCoordinates];

  //     sum1 += current['latitude'] * next['longitude'];
  //     sum2 += current['longitude'] * next['latitude'];
  //   }

  //   setState(() {
  //     _area = (sum1 - sum2).abs() / 2.0;
  //   });
  // }

  void _calculateArea() {
    if (_coordinates.length < _maxCoordinates) return;

    const double R = 6371000; // Radius of the Earth in meters
    double sum1 = 0.0, sum2 = 0.0;

    // Convert latitude and longitude to Cartesian coordinates
    List<Map<String, double>> cartesianCoords = _coordinates.map((coord) {
      double lat = coord['latitude']! * (pi / 180); // Convert to radians
      double lon = coord['longitude']! * (pi / 180); // Convert to radians
      return {
        'x': R * cos(lat) * cos(lon),
        'y': R * cos(lat) * sin(lon),
      };
    }).toList();

    for (int i = 0; i < cartesianCoords.length; i++) {
      final current = cartesianCoords[i];
      final next = cartesianCoords[(i + 1) % _maxCoordinates];

      sum1 += current['x']! * next['y']!;
      sum2 += current['y']! * next['x']!;
    }

    setState(() {
      _area = (sum1 - sum2).abs() / 2.0;
      print("area -> ${_area}"); // Area in square meters
    });
  }

  double calculatePolygonArea(List<LatLng> points) {
    if (points.length != 4) {
      throw ArgumentError(
          'Exactly 4 coordinates are required to calculate the area.');
    }

    // Geodesy instance
    final geodesy = Geodesy();

    // Calculate the area
    double area = geodesy.calculatePolygonArea(points);
    return area; // Area is in square meters
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
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: "Area",
                      hintText: _area == 0
                          ? "..."
                          : "${_area.toStringAsFixed(2)} sq. meters",
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
                    Navigator.pop(context, _coordinates);
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
