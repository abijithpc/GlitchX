import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/Bloc/profile_event.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/Bloc/profile_state.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/Bloc/profilebloc.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart' as latLng;

class LocationSelectionPage extends StatefulWidget {
  const LocationSelectionPage({super.key});

  @override
  State<LocationSelectionPage> createState() => _LocationSelectionPageState();
}

class _LocationSelectionPageState extends State<LocationSelectionPage> {
  latLng.LatLng? selectedLocation;
  String? selectedAddress;
  final MapController mapController = MapController();
  final TextEditingController searchController = TextEditingController();

  Future<void> _searchLocation(String query) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=1',
    );
    final response = await http.get(
      url,
      headers: {'User-Agent': 'Flutter App'},
    );

    if (response.statusCode == 200) {
      final List results = json.decode(response.body);
      if (results.isNotEmpty) {
        final lat = double.parse(results[0]['lat']);
        final lon = double.parse(results[0]['lon']);
        final newLocation = latLng.LatLng(lat, lon);

        setState(() {
          selectedLocation = newLocation;
          selectedAddress = results[0]['display_name'];
        });

        mapController.move(newLocation, 15);
      } else {
        _showSnackBar("Location not found");
      }
    } else {
      _showSnackBar("Error fetching location");
    }
  }

  Future<void> _reverseGeocode(latLng.LatLng location) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/reverse?lat=${location.latitude}&lon=${location.longitude}&format=json',
    );
    final response = await http.get(
      url,
      headers: {'User-Agent': 'Flutter App'},
    );

    if (response.statusCode == 200) {
      final Map result = json.decode(response.body);
      setState(() {
        selectedAddress = result['display_name'];
      });
    } else {
      _showSnackBar("Error fetching address");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Location')),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(child: CupertinoActivityIndicator(radius: 16));
          } else if (state is ProfileError) {
            return Text(state.message);
          } else if (state is ProfileLoaded) {
            return Stack(
              children: [
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    initialCenter: latLng.LatLng(10.8505, 76.2711),
                    initialZoom: 13.0,
                    onTap: (tapPosition, point) {
                      setState(() {
                        selectedLocation = point;
                      });
                      _reverseGeocode(point); // Get address on tap
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    if (selectedLocation != null)
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 40,
                            height: 40,
                            point: selectedLocation!,
                            child: const Icon(
                              Icons.location_on,
                              size: 40,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                Positioned(
                  top: 10,
                  left: 12,
                  right: 12,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: searchController,
                      textInputAction: TextInputAction.search,
                      onSubmitted: _searchLocation,
                      decoration: InputDecoration(
                        hintText: 'Search for a location',
                        prefixIcon: const Icon(Icons.search),
                        contentPadding: const EdgeInsets.all(12),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                if (selectedLocation != null)
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.check),
                      label: const Text("Confirm Location"),
                      onPressed: () {
                        if (selectedAddress != null) {
                          context.read<ProfileBloc>().add(
                            UpdateLocationEvent(selectedAddress!),
                          );
                          Navigator.pop(context); // Return address
                        }
                      },
                    ),
                  ),
                if (selectedAddress != null)
                  Positioned(
                    bottom: 70,
                    left: 20,
                    right: 20,
                    child: Card(
                      color: Colors.white,
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Selected Address: $selectedAddress',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
