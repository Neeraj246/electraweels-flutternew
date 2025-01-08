import 'package:dio/dio.dart';
import 'package:electra_wheels/login/loginapi.dart';
import 'package:flutter/material.dart';

class AddReviewScreen extends StatefulWidget {
  @override
  _AddReviewScreenState createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  List<Map<String, dynamic>> locations = []; // Empty list initially
  String? _selectedStation;
  int?   _selectedid;
  double _rating = 3.0;
  final TextEditingController _reviewController = TextEditingController();

  // Method to fetch stations from the API
  Future<void> _fetchStations() async {
    try {
      Response response = await Dio().get(
        'http://192.168.1.253:5000/viewStations', // Replace with your actual API endpoint
      );

      if (response.statusCode == 200) {
        setState(() {
          // Assuming the response is a list of stations
          locations = List<Map<String, dynamic>>.from(response.data);
          print("wwwww$locations");

          // Set the first station as the default selected station
          if (locations.isNotEmpty) {
            _selectedStation = locations[0]['Name'];
            _selectedid=locations[0]["id"];
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to load stations.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching stations: $e")),
      );
    }
  }

  // Method to submit the review
  void _submitReview() async {
    final String reviewText = _reviewController.text.trim();

    if (_selectedStation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a station.")),
      );
      return;
    }

    if (reviewText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please add a review before submitting.")),
      );
      return;
    }

    for(Map item in locations){
      if (_selectedStation==item['Name']) {
        _selectedid=item['id'];
      }
    }

    // Prepare the feedback data
    final Map<String, dynamic> feedbackData = {
      // 'Chargingstation': _selectedStation,
      'Feedback': reviewText,
      'Rate': _rating.toString(),
      'Chargingstation':_selectedid,
      'USER':lid,
    };

    try {
      Response response = await Dio().post(
        '$baseurl/submitfeedback', 
        data: feedbackData,
      );
print(response.data);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Review for $_selectedStation submitted successfully!"),
          ),
        );

        _reviewController.clear();
        setState(() {
          _rating = 3.0;
          _selectedStation = null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to submit the review. Please try again.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e")),
      );
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchStations(); // Fetch stations when the screen loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Review',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 33, 58, 34),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Charging Station:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedStation, // Ensure this value is never null
              onChanged: (value) {
                setState(() {
                  _selectedStation = value;
                });
              },
              items: locations.isNotEmpty
                  ? locations.map((station) {
                      return DropdownMenuItem<String>(
                        value: station['Name'],
                        child: Text(station['Name']),
                      );
                    }).toList()
                  : [
                      DropdownMenuItem<String>(
                        value: '',
                        child: Text("No stations available"),
                      ),
                    ],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Choose a station',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Rate this station:',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  Text(
                    _rating.toStringAsFixed(1),
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    value: _rating,
                    onChanged: (value) {
                      setState(() {
                        _rating = value;
                      });
                    },
                    min: 1,
                    max: 5,
                    divisions: 40,
                    label: _rating.toStringAsFixed(1),
                    activeColor: Colors.green,
                    inactiveColor: Colors.grey[300],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Write your feedback:',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _reviewController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Share your experience...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _submitReview,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  'Submit Review',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
