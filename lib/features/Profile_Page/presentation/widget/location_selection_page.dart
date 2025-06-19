import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

class LocationPickerPage extends StatefulWidget {
  const LocationPickerPage({super.key});

  @override
  State<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  LatLng _selectedLocation = LatLng(
    37.7749,
    -122.4194,
  ); // default: San Francisco
  String _address = '';
  final TextEditingController _searchController = TextEditingController();

  Future<void> _getAddressFromLatLng() async {
    try {
      final placemarks = await placemarkFromCoordinates(
        _selectedLocation.latitude,
        _selectedLocation.longitude,
      );
      final place = placemarks.first;
      setState(() {
        _address =
            '${place.name}, ${place.street}, ${place.locality}, ${place.country}';
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> _getLatLngFromAddress(String address) async {
    try {
      final locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        final loc = locations.first;
        final latlng = LatLng(loc.latitude, loc.longitude);
        setState(() {
          _selectedLocation = latlng;
        });
        _getAddressFromLatLng();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location not found. Please try again.')),
      );
    }
  }

  void _onTapMap(LatLng latlng) {
    setState(() {
      _selectedLocation = latlng;
    });
    _getAddressFromLatLng();
  }

  void _submitLocation() {
    Navigator.pop(context, _address); // return address to previous screen
  }

  @override
  void initState() {
    super.initState();
    _getAddressFromLatLng();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pick Location')),
      body: Column(
        children: [
          // 🔍 Search Field
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        _getLatLngFromAddress(value.trim());
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Search location',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          if (_searchController.text.trim().isNotEmpty) {
                            _getLatLngFromAddress(
                              _searchController.text.trim(),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🗺️ Map
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: _selectedLocation,
                initialZoom: 13.0,
                onTap: (tapPos, point) => _onTapMap(point),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 60,
                      height: 60,
                      point: _selectedLocation,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 📍 Address + Confirm Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text("Address: $_address", textAlign: TextAlign.center),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: _address.isNotEmpty ? _submitLocation : null,
                  icon: Icon(Icons.check),
                  label: Text("Select This Location"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
