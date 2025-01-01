import 'package:flutter/material.dart';
// Main Screen displaying a list of users
class OrderListScreen extends StatelessWidget {
   OrderListScreen({Key? key}) : super(key: key);

  final List<Order> orders = [
    Order(
      orderId: 'ORD12345',
      userName: 'John Doe',
      sparePartsOrdered: 'Battery, Motor',
      category: 'Battery',
      deliveryStatus: 'Delivered',
      shippingAddress: '123, Main Street, City',
    ),
    Order(
      orderId: 'ORD12346',
      userName: 'Jane Smith',
      sparePartsOrdered: 'Charging Cable',
      category: 'Charging Cable',
      deliveryStatus: 'Pending',
      shippingAddress: '456, Elm Street, City',
    ),
    // Add more orders as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders List'),
        backgroundColor: const Color(0xFF00796B),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(order.userName),
              subtitle: Text(order.sparePartsOrdered),
              trailing: IconButton(
                icon: const Icon(Icons.info),
                onPressed: () {
                  // Navigate to PaymentStatusScreen with the selected order's details
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentStatusScreen(
                        isSuccess: true,
                        orderId: order.orderId,
                        userName: order.userName,
                        sparePartsOrdered: order.sparePartsOrdered,
                        deliveryStatus: order.deliveryStatus,
                        shippingAddress: order.shippingAddress,
                        category: order.category,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

// Model class to store order details
class Order {
  final String orderId;
  final String userName;
  final String sparePartsOrdered;
  final String category;
  final String deliveryStatus;
  final String shippingAddress;

  Order({
    required this.orderId,
    required this.userName,
    required this.sparePartsOrdered,
    required this.category,
    required this.deliveryStatus,
    required this.shippingAddress,
  });
}

// Payment Status Screen (As per your previous code)
class PaymentStatusScreen extends StatelessWidget {
  final bool isSuccess;
  final String orderId;
  final String userName;
  final String sparePartsOrdered;
  final String deliveryStatus;
  final String shippingAddress;
  final String category;

  const PaymentStatusScreen({
    Key? key,
    required this.isSuccess,
    required this.orderId,
    required this.userName,
    required this.sparePartsOrdered,
    required this.deliveryStatus,
    required this.shippingAddress,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Status'),
        backgroundColor: const Color(0xFF00796B), // Dark teal
        centerTitle: true,
      ),
      body: SingleChildScrollView( // Wrapping the body in SingleChildScrollView
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Payment Status Icon
            Icon(
              isSuccess ? Icons.check_circle : Icons.error,
              size: 100,
              color: isSuccess ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 20),
            // Payment Status Text
            Text(
              isSuccess ? "Payment Successful!" : "Payment Failed!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isSuccess ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 30),

            // Payment Details Card
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildDetailRow("Order ID", orderId),
                    const Divider(),
                    _buildDetailRow("User Name", userName),
                    const Divider(),
                    _buildDetailRow("Category", category),
                    const Divider(),
                    _buildDetailRow("Spare Parts Ordered", sparePartsOrdered),
                    const Divider(),
                    _buildDetailRow("Delivery Status", deliveryStatus),
                    const Divider(),
                    _buildDetailRow("Shipping Address", shippingAddress),
                    const Divider(),
                    _buildDetailRow("Amount Paid", "₹500.00"),
                    const Divider(),
                    _buildDetailRow("Payment Method", "UPI"),
                    const Divider(),
                    _buildDetailRow("Transaction ID", "TXN12345"),
                    const Divider(),
                    _buildDetailRow("Date & Time", "20 Nov 2024, 3:45 PM"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Helper method for building detail rows
  Widget _buildDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
