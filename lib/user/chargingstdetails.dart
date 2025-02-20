import 'package:electra_wheels/login/loginapi.dart';
import 'package:electra_wheels/services/user/bookstationapi.dart';
import 'package:electra_wheels/user/getNearbyStations.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class NearbyLocationsScreen extends StatefulWidget {
  const NearbyLocationsScreen({super.key});

  @override
  _NearbyLocationsScreenState createState() => _NearbyLocationsScreenState();
}

class _NearbyLocationsScreenState extends State<NearbyLocationsScreen> {
  late Position _currentPosition;
  // List<Map<String, dynamic>> nearbyLocations = [];
  bool isLoading = false;

  // Predefined list of EV charging stations
   List<Map<String, dynamic>> locations = [
   
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
 locations=await     getNearByStationsApi({
        'lalitude': _currentPosition.latitude,
        'logitude': _currentPosition.longitude
      });
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
  // void _findNearbyLocations() {
  //   List<Map<String, dynamic>> withinRadius = [];

  //   for (var location in locations) {
  //     double distance = Geolocator.distanceBetween(
  //       _currentPosition.latitude,
  //       _currentPosition.longitude,
  //       location['latitude'],
  //       location['longitude'],
  //     );

  //     if (distance <= 5000) {
  //       withinRadius.add({
  //         'name': location['name'],
  //         'latitude': location['latitude'],
  //         'longitude': location['longitude'],
  //         'distance': distance,
        
  //       });
  //     }
  //   }

  //   setState(() {
  //     nearbyLocations = withinRadius;
  //   });
  // }

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
                : locations.isEmpty
                    ? Text('No locations found within 5 km radius.')
                    : Expanded(
                        child: ListView.builder(
                          itemCount: locations.length,
                          itemBuilder: (context, index) {
                            final location = locations[index];
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
                                        location['Name'],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'No: ${(location['StationNumber'])} ',
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





class EVStationDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> location;

  const EVStationDetailsScreen({super.key, required this.location});

  @override
  _EVStationDetailsScreenState createState() => _EVStationDetailsScreenState();
}

class _EVStationDetailsScreenState extends State<EVStationDetailsScreen> {
  // The currently selected payment method
  String? _selectedPaymentMethod;

  // Available payment methods
  final List<String> paymentMethods = [
    'UPI',
    'Credit/Debit Card',
    'Net Banking',
    'Cash',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 58, 34),
        title: Text(
          widget.location['Name'],
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
              widget.location['Name'],
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Coordinates
            Text(
              'Latitude: ${widget.location['latitude']} | Longitude: ${widget.location['longitude']}',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            Divider(thickness: 1, height: 30),

            // Payment Methods - Selection using Chips
            Text(
              'Select Payment Method',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: paymentMethods.map((method) {
                return ChoiceChip(
                  label: Text(method),
                  selected: _selectedPaymentMethod == method,
                  onSelected: (isSelected) {
                    setState(() {
                      _selectedPaymentMethod = isSelected ? method : null;
                    });
                  },
                  selectedColor: Colors.blue[300],
                  backgroundColor: Colors.grey[200],
                  labelStyle: TextStyle(
                    color: _selectedPaymentMethod == method
                        ? Colors.white
                        : Colors.black,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 12),
            // If a payment method is selected, show it
            if (_selectedPaymentMethod != null)
              Text(
                'Selected Payment Method: $_selectedPaymentMethod',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            Divider(thickness: 1, height: 30),

            // Operating Hours
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
                  if (_selectedPaymentMethod == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select a payment method!')),
                    );
                  } else {
                    Map<String, dynamic> data={
                      'USER':lid,
                      'STATION':widget.location['id']  ,
                      'Amount':100  ,
                      'Status':'pendiing',

        
                      

                    };
                    BookChargingStation(data,context);


                    // booking
                  
                  }
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
