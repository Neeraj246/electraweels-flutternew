import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class ChargingStationsMap extends StatefulWidget {
  @override
  _ChargingStationsMapState createState() => _ChargingStationsMapState();
}

class _ChargingStationsMapState extends State<ChargingStationsMap> {
  GoogleMapController? mapController;
  LatLng? currentLocation;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
      markers.add(
        Marker(
          markerId: MarkerId("currentLocation"),
          position: currentLocation!,
          infoWindow: InfoWindow(title: "You are here"),
        ),
      );

      // Adding a fake EV station approximately 1 km north-east of the current location
      LatLng fakeEVStationLocation = LatLng(
        position.latitude + 0.009, // Roughly 1 km latitude offset
        position.longitude + 0.009, // Roughly 1 km longitude offset
      );

      markers.add(
        Marker(
          markerId: MarkerId("fakeEVStation"),
          position: fakeEVStationLocation,
          infoWindow: InfoWindow(
            title: "EV Charging Station",
            snippet: "Fast and slow charging available",
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Charging Stations',style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 33, 58, 34),
      ),
      body: currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: currentLocation!,
                zoom: 14.0,
              ),
              markers: markers,
              onMapCreated: (controller) {
                mapController = controller;
              },
            ),
    );
  }
}
