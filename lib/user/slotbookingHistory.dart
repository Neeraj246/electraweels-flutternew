// import 'package:electra_wheels/services/user/boookinghistoryApi.dart';
// import 'package:flutter/material.dart';

// class SlotBookingHistoryScreen extends StatefulWidget {
//   // Sample booking data
//   final List<Map<String, dynamic>> bookingHistory;

//   const SlotBookingHistoryScreen({super.key, required this.bookingHistory});

//   @override
//   State<SlotBookingHistoryScreen> createState() => _SlotBookingHistoryScreenState();
// }

// class _SlotBookingHistoryScreenState extends State<SlotBookingHistoryScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Booking History'),
//         backgroundColor: const Color.fromARGB(255, 33, 58, 34),
//       ),
//       body: ListView.builder(
//         itemCount: widget.bookingHistory.length,
//         itemBuilder: (context, index) {
//           var booking = widget.bookingHistory[index];
//           return ListTile(
//             leading: Icon(
//               Icons.location_on, // Placeholder icon, can be customized
//               color: Colors.blue,
//             ),
//             title: Text(
//               'Station: ${booking['STATION']}',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//             ),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   ' Amount: \$${booking['Amount']} ',
//                   style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     // Show confirmation dialog before removing the booking
//                     _showConfirmationDialog(context, index);
//                   },
//                   child: Text('Mark as Available'),
//                 ),
//               ],
//             ),
//             trailing: Text(
//               'Status: ${booking['Status']}',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//             onTap: () {
//               // Handle tap on booking, show details or navigate
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Tapped on Station ${booking['STATION']}')),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   // Function to show confirmation dialog and handle item removal
//   void _showConfirmationDialog(BuildContext context, int index) {
//     showDialog(
//       context: context,
//       barrierDismissible: false, // user must tap a button to close the dialog
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirm Action'),
//           content: Text('Are you sure you want to mark this as available?'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//               BookingstatusApi();
//                 setState(() {
//                   widget.bookingHistory.removeAt(index); // Remove the booking
//                 });

//                 Navigator.of(context).pop(); // Close the dialog
//                 // You can add your action to mark as available here
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Marked as Available')),
//                 );
//               },
//               child: Text('Yes'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog without action
//               },
//               child: Text('No'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:dio/dio.dart';
import 'package:electra_wheels/login/loginapi.dart';
import 'package:flutter/material.dart';

class SlotBookingHistoryScreen extends StatefulWidget {
  final List<Map<String, dynamic>> bookingHistory;

  const SlotBookingHistoryScreen({super.key, required this.bookingHistory});

  @override
  State<SlotBookingHistoryScreen> createState() =>
      _SlotBookingHistoryScreenState();
}

class _SlotBookingHistoryScreenState extends State<SlotBookingHistoryScreen> {
  Dio dio = Dio();

  Future<void> bookingstatusApi(
    int index,
  ) async {
    var booking = widget.bookingHistory[index];

    try {
      Response response = await dio.post(
        "$baseurl/bookinStatus/$lid",
        data: {
          'station': booking['STATION'],
          'status': 'booked',
          'id': booking['id'],
        },
      );

      print("stattttt$response");

      if (response.statusCode == 200) {
        print('API Request Successful');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Booking marked as available!')),
        );
      } else {
        print('API Request Failed');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to mark as available.')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking History'),
        backgroundColor: const Color.fromARGB(255, 33, 58, 34),
      ),
      body: ListView.builder(
        itemCount: widget.bookingHistory.length,
        itemBuilder: (context, index) {
          var booking = widget.bookingHistory[index];
          return ListTile(
            leading: Icon(
              Icons.location_on,
              color: Colors.blue,
            ),
            title: Text(
              'Station: ${booking['STATION']}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Amount: \$${booking['Amount']}',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                TextButton(
                  onPressed: () {
                    _showConfirmationDialog(context, index);
                  },
                  child: Text('Mark as Available'),
                ),
              ],
            ),
            trailing: Text(
              'Status: ${booking['Status']}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Tapped on Station ${booking['STATION']}')),
              );
            },
          );
        },
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Action'),
          content: Text('Are you sure you want to mark this as available?'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                await bookingstatusApi(index);

                setState(() {
                  widget.bookingHistory.removeAt(index);
                });

                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }
}
