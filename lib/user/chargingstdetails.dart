import 'package:electra_wheels/user/slotbooking.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class NearbyLocationsScreen extends StatefulWidget {
  @override
  _NearbyLocationsScreenState createState() => _NearbyLocationsScreenState();
}

class _NearbyLocationsScreenState extends State<NearbyLocationsScreen> {
  late Position _currentPosition;
  List<Map<String, dynamic>> nearbyLocations = [];
  bool isLoading = false;

  // Predefined list of EV charging stations
  final List<Map<String, dynamic>> locations = [
    {'latitude': 11.2612, 'longitude': 75.7916, 'name': 'ECO Ev station'},
    {
      'latitude': 11.2600,
      'longitude': 75.7926,
      'name': 'Goodness charging station'
    },
    {
      'latitude': 11.2687,
      'longitude': 75.7928,
      'name': 'Supreme charging center'
    },
    {'latitude': 11.2806, 'longitude': 75.7847, 'name': 'Fast charging center'},
  ];

  // Function to get the current location
  Future<void> _getCurrentLocation() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Check location services and permissions
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Location services are disabled.")),
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    "Location permissions are permanently denied. Please enable them in settings.")),
          );
          return;
        }
      }

      // Get current location
      _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Calculate nearby locations
      _findNearbyLocations();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error getting location: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Function to find nearby locations within 5 km
  void _findNearbyLocations() {
    List<Map<String, dynamic>> withinRadius = [];

    for (var location in locations) {
      double distance = Geolocator.distanceBetween(
        _currentPosition.latitude,
        _currentPosition.longitude,
        location['latitude'],
        location['longitude'],
      );

      if (distance <= 5000) {
        withinRadius.add({
          'name': location['name'],
          'latitude': location['latitude'],
          'longitude': location['longitude'],
          'distance': distance,
        
        });
      }
    }

    setState(() {
      nearbyLocations = withinRadius;
    });
  }

  // Navigate to details screen
  void _navigateToDetails(Map<String, dynamic> location) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EVStationDetailsScreen(location: location),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: const Color.fromARGB(255, 33, 58, 34),
        title: Text(
          'Nearby Locations',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: Text('Get My Current Location'),
            ),
            SizedBox(height: 20),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : nearbyLocations.isEmpty
                    ? Text('No locations found within 5 km radius.')
                    : Expanded(
                        child: ListView.builder(
                          itemCount: nearbyLocations.length,
                          itemBuilder: (context, index) {
                            final location = nearbyLocations[index];
                            return GestureDetector(
                              onTap: () => _navigateToDetails(location),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 5,
                                margin: EdgeInsets.symmetric(vertical: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        location['name'],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Distance: ${(location['distance'] / 1000).toStringAsFixed(2)} km',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}

// EV Station Details Screen
class EVStationDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> location;

  EVStationDetailsScreen({required this.location});

  @override
  Widget build(BuildContext context) {
    // Mock details for demonstration
    final List<Map<String, String>> chargingDetails = [
      {
        'type': 'Fast Charging',
        'price': '₹12/kWh',
        'time': '8:00 AM - 10:00 PM'
      },
      {'type': 'Normal Charging', 'price': '₹8/kWh', 'time': '24 Hours'},
    ];

    final List<String> paymentMethods = [
      'UPI',
      'Credit/Debit Card',
      'Net Banking',
      'Cash',
    ];

    return Scaffold(
      appBar: AppBar(
         backgroundColor: const Color.fromARGB(255, 33, 58, 34),
        title: Text(
          location['name'],
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Station Name
            Text(
              location['name'],
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Coordinates
            Text(
              'Latitude: ${location['latitude']} | Longitude: ${location['longitude']}',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            // Distance
            Text(
              'Distance: ${(location['distance'] / 1000).toStringAsFixed(2)} km',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            Divider(thickness: 1, height: 30),

            // Charging Details
            Text(
              'Charging Details',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: chargingDetails.length,
              itemBuilder: (context, index) {
                final detail = chargingDetails[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.electric_bolt, color: Colors.orange),
                    title: Text(detail['type'] ?? ''),
                    subtitle: Text(
                        'Price: ${detail['price']} | Available: ${detail['time']}'),
                  ),
                );
              },
            ),
            Divider(thickness: 1, height: 30),

            // Payment Options
            Text(
              'Payment Methods',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: paymentMethods
                  .map((method) => Chip(
                        label: Text(method),
                        avatar: Icon(
                          Icons.payment,
                          color: Colors.blue,
                        ),
                        backgroundColor: Colors.blue[50],
                      ))
                  .toList(),
            ),
            Divider(thickness: 1, height: 30),

            // Open Hours
            Text(
              'Operating Hours',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'Fast Charging: 8:00 AM - 10:00 PM\nNormal Charging: 24 Hours',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),

            // Book Now Button
            SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SlotBookingScreen()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Booking functionality coming soon!')),
                  );
                },
                icon: Icon(Icons.book_online),
                label: Text('Book a Charging Slot'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: NearbyLocationsScreen()));
}
