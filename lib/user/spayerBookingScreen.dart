import 'package:electra_wheels/login/loginapi.dart';
import 'package:electra_wheels/services/user/spayerBookingApi.dart';
import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  final itemdata;

  const BookingScreen({super.key,required this.itemdata});
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
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
        title: Text('Booking Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text('Item: ${widget.itemdata['Name']}',
             style: TextStyle(fontSize: 24, color: Colors.black)),

            Text('Amount: \$ ${widget.itemdata['Amount']}',
            style: TextStyle(fontSize: 24, color: Colors.black)),

            // Title
            SizedBox(height: 30,),
            Text(
              'Select Payment Method',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Payment Methods - Radio Buttons
            Column(
              children: paymentMethods.map((method) {
                return RadioListTile<String>(
                  title: Text(method),
                  value: method,
                  groupValue: _selectedPaymentMethod,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedPaymentMethod = value;
                    });
                  },
                  activeColor: Colors.green,
                );
              }).toList(),
            ),

            SizedBox(height: 30),

            // Pay Now Button
            Center(
              child: ElevatedButton.icon(
                onPressed: _selectedPaymentMethod == null
                    ? () {
                        // If no payment method is selected, show a SnackBar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please select a payment method!')),
                        );
                      }
                    : () {
                      Map<String,dynamic>data={
                        'SPARE':widget.itemdata['Name'],
                        'Amount':widget.itemdata['Amount'],
                        'PaymentMethod':_selectedPaymentMethod,
                        'Status':'pending',
                        'USER':lid
                      };
                        // Handle the payment process
                       BookSpayerApi(data,context);
                      },
                icon: Icon(Icons.payment),
                label: Text('Pay Now'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
