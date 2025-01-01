import 'package:flutter/material.dart';

class DeliveryStatusScreen extends StatelessWidget {
  final List<Map<String, dynamic>> deliveries = [
    {
      'orderId': '#1234',
      'item': 'EV Battery Spare',
      'status': 'Out for Delivery',
      'expectedDelivery': '23 Nov, 2024',
    },
    {
      'orderId': '#1235',
      'item': 'Charging Cable',
      'status': 'Delivered',
      'expectedDelivery': '21 Nov, 2024',
    },
    {
      'orderId': '#1236',
      'item': 'Wheel Alignment Kit',
      'status': 'Processing',
      'expectedDelivery': '25 Nov, 2024',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Status'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: deliveries.length,
          itemBuilder: (context, index) {
            final delivery = deliveries[index];
            return _buildDeliveryCard(delivery);
          },
        ),
      ),
    );
  }

  Widget _buildDeliveryCard(Map<String, dynamic> delivery) {
    Color statusColor;

    switch (delivery['status']) {
      case 'Delivered':
        statusColor = Colors.green;
        break;
      case 'Out for Delivery':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.blue;
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              delivery['item'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.confirmation_number, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  delivery['orderId'],
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.info, color: statusColor),
                const SizedBox(width: 8),
                Text(
                  delivery['status'],
                  style: TextStyle(fontSize: 16, color: statusColor),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.calendar_today, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  'Expected Delivery:',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              delivery['expectedDelivery'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {
                  // View more details action
                },
                icon: const Icon(Icons.arrow_forward, size: 16),
                label: const Text('View Details'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
