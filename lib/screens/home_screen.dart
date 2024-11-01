import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_location/services/gps_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: GpsService.determinePosition(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }
          Position position = snapshot.data!;
          return GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 15.4746,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('my-location'),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueViolet),
                position: LatLng(position.latitude, position.longitude),
                infoWindow: const InfoWindow(title: 'My Location'),
              ),
            },
          );
        },
      ),
    );
  }
}
