import 'package:flutter/material.dart';

class AddReviewScreen extends StatefulWidget {
  @override
  _AddReviewScreenState createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final List<Map<String, dynamic>> locations = [
    {'name': 'ECO EV Station'},
    {'name': 'Goodness Charging Station'},
    {'name': 'Supreme Charging Center'},
    {'name': 'Fast Charging Center'},
  ];

  String? _selectedStation;
  double _rating = 3.0;
  final TextEditingController _reviewController = TextEditingController();

  void _submitReview() {
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

    // Handle submission logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Review for $_selectedStation submitted successfully!")),
    );

    // Clear the fields after submission
    _reviewController.clear();
    setState(() {
      _rating = 3.0;
      _selectedStation = null;
    });
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
              value: _selectedStation,
              onChanged: (value) {
                setState(() {
                  _selectedStation = value;
                });
              },
              items: locations.map((station) {
                return DropdownMenuItem<String>(
                  value: station['name'],
                  child: Text(station['name']),
                );
              }).toList(),
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

void main() {
  runApp(MaterialApp(
    home: AddReviewScreen(),
  ));
}
