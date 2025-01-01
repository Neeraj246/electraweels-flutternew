import 'package:flutter/material.dart';

class ViewPaymentStatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Status'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          children: [
            // Summary Section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _summaryItem('Total', '₹50,000', Colors.blue),
                    _summaryItem('Pending', '₹5,000', Colors.orange),
                    _summaryItem('Completed', '₹45,000', Colors.green),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),

            // Search and Filter Section
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Search by Order ID',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                DropdownButton<String>(
                  items: [
                    DropdownMenuItem(child: Text('All'), value: 'all'),
                    DropdownMenuItem(child: Text('Pending'), value: 'pending'),
                    DropdownMenuItem(child: Text('Completed'), value: 'completed'),
                  ],
                  onChanged: (value) {
                    // Handle filter logic
                  },
                  hint: Text('Filter'),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),

            // Payment Status List
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Example item count
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                    elevation: 2,
                    child: ListTile(
                      title: Text('Order ID: #12345${index + 1}'),
                      subtitle: Text('Customer: John Doe\nAmount: ₹5000'),
                      trailing: Chip(
                        label: Text(
                          index % 2 == 0 ? 'Completed' : 'Pending',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: index % 2 == 0 ? Colors.green : Colors.orange,
                      ),
                      onTap: () {
                        // Show payment details dialog
                        _showPaymentDetailsDialog(context);
                      },
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

  Widget _summaryItem(String title, String amount, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          amount,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }

  void _showPaymentDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Payment Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Transaction ID: TXN123456789'),
              Text('Order ID: #123456'),
              Text('Customer: John Doe'),
              Text('Amount: ₹5000'),
              Text('Payment Mode: Credit Card'),
              Text('Status: Completed'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
