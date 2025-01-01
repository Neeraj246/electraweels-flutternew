import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 33, 58, 34),
          title: Text("Payment",style: TextStyle(color: Colors.white),)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Booking Summary",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Charging Station: EcoCharge Station"),
            Text("Selected Slot: Slot 3"), // Assuming slot 3 for example
            Text("Selected Time: 3:00 PM"), // Example time
            Text("Total Cost: ₹150"), // Example cost
            SizedBox(height: 20),
            Text(
              "Choose Payment Method",
              style: TextStyle(fontSize: 18),
            ),
            ListTile(
              title: Text("Credit/Debit Card"),
              leading: Radio(value: 0, groupValue: 1, onChanged: (value) {}),
            ),
            ListTile(
              title: Text("UPI"),
              leading: Radio(value: 1, groupValue: 1, onChanged: (value) {}),
            ),
            ListTile(
              title: Text("Wallet"),
              leading: Radio(value: 2, groupValue: 1, onChanged: (value) {}),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Payment Successful")));
                },
                child: Text("Pay Now"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
