import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const LatLng myLocation = LatLng(10.8231, 106.6297);

  final Set<Marker> markers = {
    const Marker(
      markerId: MarkerId('my_location'),
      position: myLocation,
      infoWindow: InfoWindow(
        title: 'Vị trí của tôi',
        snippet: 'TP. Hồ Chí Minh',
      ),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: myLocation,
          zoom: 14,
        ),
        markers: markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
      ),
    );
  }
}