// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';

// class NearbyLocationsScreen extends StatefulWidget {
//   @override
//   _NearbyLocationsScreenState createState() => _NearbyLocationsScreenState();
// }

// class _NearbyLocationsScreenState extends State<NearbyLocationsScreen> {
//   late Position _currentPosition;
//   List<Map<String, dynamic>> nearbyLocations = [];
//   bool isLoading = false;

//   // Predefined list of EV charging stations
//   final List<Map<String, dynamic>> locations = [
//     {'latitude': 11.2612, 'longitude': 75.7916, 'name': 'ECO Ev station'},
//     {'latitude': 11.2600, 'longitude': 75.7926, 'name': 'Goodness charging station'},
//     {'latitude': 11.2687, 'longitude': 75.7928, 'name': 'Supreme charging center'},
//     {'latitude': 11.2806, 'longitude': 75.7847, 'name': 'Fast charging center'},
//   ];

//   // Function to get the current location
//   Future<void> _getCurrentLocation() async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       // Check location services and permissions
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Location services are disabled.")),
//         );
//         return;
//       }

//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.deniedForever) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//                 content: Text(
//                     "Location permissions are permanently denied. Please enable them in settings.")),
//           );
//           return;
//         }
//       }

//       // Get current location
//       _currentPosition = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);

//       // Calculate nearby locations
//       _findNearbyLocations();

//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error getting location: $e")),
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   // Function to find nearby locations within 5 km
//   void _findNearbyLocations() {
//     List<Map<String, dynamic>> withinRadius = [];

//     for (var location in locations) {
//       double distance = Geolocator.distanceBetween(
//         _currentPosition.latitude,
//         _currentPosition.longitude,
//         location['latitude'],
//         location['longitude'],
//       );

//       if (distance <= 5000) {
//         withinRadius.add({
//           'name': location['name'],
//           'distance': distance,
//         });
//       }
//     }

//     setState(() {
//       nearbyLocations = withinRadius;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Nearby Locations'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ElevatedButton(
//               onPressed: _getCurrentLocation,
//               child: Text('Get My Current Location'),
//             ),
//             SizedBox(height: 20),
//             isLoading
//                 ? Center(child: CircularProgressIndicator())
//                 : nearbyLocations.isEmpty
//                     ? Text('No locations found within 5 km radius.')
//                     : Expanded(
//                         child: ListView.builder(
//                           itemCount: nearbyLocations.length,
//                           itemBuilder: (context, index) {
//                             final location = nearbyLocations[index];
//                             return Card(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               elevation: 5,
//                               margin: EdgeInsets.symmetric(vertical: 8),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(16.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       location['name'],
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     SizedBox(height: 8),
//                                     Text(
//                                       'Distance: ${(location['distance'] / 1000).toStringAsFixed(2)} km',
//                                       style: TextStyle(
//                                         fontSize: 15,
//                                         color: Colors.grey[600],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(home: NearbyLocationsScreen()));
// }
