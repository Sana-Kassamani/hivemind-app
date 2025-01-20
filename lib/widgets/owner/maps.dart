import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hivemind_app/providers/apiaries.provider.dart';
import 'package:provider/provider.dart';

class ApiariesMap extends StatefulWidget {
  const ApiariesMap({super.key});

  @override
  State<ApiariesMap> createState() => _ApiariesMapState();
}

class _ApiariesMapState extends State<ApiariesMap> {
  late GoogleMapController mapController;
  final Map<String, Marker> _markers = {};

  void getMarkers({required apiaries}) {
    setState(() {
      _markers.clear();
      for (var apiary in apiaries) {
        final marker = Marker(
          markerId: MarkerId(apiary.getId()),
          position: LatLng(apiary.lat, apiary.lng),
          infoWindow: InfoWindow(
            title: apiary.label,
            snippet: apiary.location,
          ),
        );
        _markers[apiary.getId()] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Apiaries on Map"),
      ),
      body: Consumer<Apiaries>(
          builder: (BuildContext context, Apiaries value, Widget? child) {
        return GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            setState(() {
              _markers.clear();
              for (var apiary in value.apiariesList) {
                print(
                    "${apiary.location} _ ${apiary.latitude} _ ${apiary.longitude}");
                final marker = Marker(
                  markerId: MarkerId(apiary.getId()),
                  position: LatLng(apiary.latitude, apiary.longitude),
                  infoWindow: InfoWindow(
                    title: apiary.label,
                    snippet: apiary.location,
                  ),
                );
                _markers[apiary.getId()] = marker;
              }
            });
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(33.88, 35.49),
            zoom: 6,
          ),
          markers: _markers.values.toSet(),
        );
      }),
    );
  }
}
