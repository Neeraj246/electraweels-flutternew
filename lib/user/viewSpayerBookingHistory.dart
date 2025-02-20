import 'package:flutter/material.dart';

class BookingHistoryScreen extends StatelessWidget {
  // Sample booking data
  final List<Map<String, dynamic>> bookingHistory;

  const BookingHistoryScreen({super.key, required this.bookingHistory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking History'),
        backgroundColor: const Color.fromARGB(255, 33, 58, 34),
      ),
      body: ListView.builder(
        itemCount: bookingHistory.length,
        itemBuilder: (context, index) {
          var booking = bookingHistory[index];
          return ListTile(
            leading: Icon(
              Icons.location_on, // Placeholder icon (you can modify based on your requirements)
              color: Colors.blue,
            ),
            title: Text(
              'User: ${booking['USER']}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Text(
              'Spare: ${booking['SPARE']}}',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            trailing: Text(' Status: ${booking['Status']}'), // Placeholder for trailing widget
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            // onTap: () {
            //   // Handle tap on booking, show details or navigate
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(content: Text('Tapped on User ${booking['USER']}')),
            //   );
            // },
          );
        },
      ),
    );
  }
}
