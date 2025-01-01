import 'package:electra_wheels/servicecenter/addspares.dart';
import 'package:electra_wheels/servicecenter/deliverystatus.dart';
import 'package:electra_wheels/servicecenter/listoforders.dart';
import 'package:electra_wheels/servicecenter/profile.dart';
import 'package:flutter/material.dart';

class ServiceCenterHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: const Color.fromARGB(255, 33, 58, 34),
        title: const Text('Dashboard',style:TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(),
                        ),
                      );
              // Navigate to Profile/Settings page
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quick Actions Column
              const Text(
                'Quick Actions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  _buildQuickAction(
                    icon: Icons.build,
                    label: 'Add Spares',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddSparesPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildQuickAction(
                    icon: Icons.payment,
                    label: 'Payment Status',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentStatusScreen(
                            isSuccess: true,
                            orderId: '',
                            userName: '',
                            sparePartsOrdered: '',
                            deliveryStatus: '',
                            shippingAddress: '',
                            category: '',
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildQuickAction(
                    icon: Icons.delivery_dining,
                    label: 'Delivery Status',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DeliveryStatusScreen(),
                        ),
                      ); // Navigate to Delivery Status Page
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 36, color: Colors.blue),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
