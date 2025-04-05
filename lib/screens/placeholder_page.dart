import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geocoding/geocoding.dart';


class PlaceholderPage extends StatefulWidget {
  const PlaceholderPage({super.key});


  @override
  State<PlaceholderPage> createState() => _HomeState();
}


class _HomeState extends State<PlaceholderPage> {
  LatLng? userLocation;
  List<Marker> petClinicMarkers = [];


  @override
  void initState() {
    super.initState();
    getUserLocation();
  }


  Future<void> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;


    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services are disabled.");
      return;
    }


    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permission denied.");
        return;
      }
    }


    if (permission == LocationPermission.deniedForever) {
      print("Location permission permanently denied.");
      return;
    }


    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);


    setState(() {
      userLocation = LatLng(position.latitude, position.longitude);
    });


    fetchPetClinics(position.latitude, position.longitude);
  }


  Future<void> fetchPetClinics(double userLat, double userLon) async {
    String overpassQuery = '''
      [out:json];
      (
        node["amenity"="veterinary"](around:10000, $userLat, $userLon);
        node["shop"="pet"](around:10000, $userLat, $userLon);
      );
      out;
    ''';


    Uri uri = Uri.parse(
        "https://overpass-api.de/api/interpreter?data=${Uri.encodeQueryComponent(overpassQuery)}");


    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Marker> markers = [];


        for (var element in data["elements"]) {
          double lat = element["lat"];
          double lon = element["lon"];
          String name = element["tags"]["name"] ?? "Unknown Clinic";


          // Check if address exists in OSM data
          String address = element["tags"]["addr:full"] ?? "Fetching address...";


          if (address == "Fetching address...") {
            address = await _getAddressFromLatLng(lat, lon);  // Wait for geocoding
          }


          markers.add(
            Marker(
              width: 40.0,
              height: 40.0,
              point: LatLng(lat, lon),
              child: GestureDetector(
                onTap: () {
                  _showClinicInfo(name, address, lat, lon);
                },
                child: Image.asset('assets/images/pet_icon.png'),
              ),
            ),
          );
        }


        setState(() {
          petClinicMarkers = markers;
        });
      } else {
        print("Error fetching data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }




  Future<String> _getAddressFromLatLng(double lat, double lon) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return "${place.street}, ${place.locality}, ${place.country}";
      }
    } catch (e) {
      print("Reverse geocoding error: $e");
    }
    return "Address not available";
  }


  void _showClinicInfo(String name, String address, double lat, double lon) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(name),
          content: Text(address),
          actions: [
            TextButton(
              onPressed: () => _openGoogleMaps(lat, lon),
              child: Text("Google Maps"),
            ),
            TextButton(
              onPressed: () => _openWaze(lat, lon),
              child: Text("Waze"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }


  void _openGoogleMaps(double lat, double lon) async {
    String googleMapsUrl =
        "https://www.google.com/maps/dir/?api=1&destination=$lat,$lon";
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      print("Could not open Google Maps.");
    }
  }


  void _openWaze(double lat, double lon) async {
    String wazeUrl = "https://waze.com/ul?ll=$lat,$lon&navigate=yes";
    if (await canLaunch(wazeUrl)) {
      await launch(wazeUrl);
    } else {
      print("Could not open Waze.");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pet Clinics Nearby')),
      body: userLocation == null
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: FlutterMap(
                options: MapOptions(
                  center: userLocation!,
                  zoom: 14.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayer(markers: petClinicMarkers),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 50.0,
                        height: 50.0,
                        point: userLocation!,
                        child: const Icon(Icons.my_location,
                            color: Colors.blue, size: 40),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}




