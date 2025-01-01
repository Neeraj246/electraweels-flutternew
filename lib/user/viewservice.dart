import 'package:flutter/material.dart';



class ServiceAndSparesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
         backgroundColor: const Color.fromARGB(255, 33, 58, 34),
          title: Text('ElectraWheels - Services & Spares',style: TextStyle(color: Colors.white),),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Service Centers', icon: Icon(Icons.build)),
              Tab(text: 'Spares', icon: Icon(Icons.settings)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ServiceCentersView(),
            SparesView(),
          ],
        ),
      ),
    );
  }
}

class ServiceCentersView extends StatelessWidget {
  final List<Map<String, String>> serviceCenters = [
    {'name': 'GreenTech EV Service', 'location': 'Mumbai'},
    {'name': 'EcoFix EV Hub', 'location': 'Delhi'},
    {'name': 'VoltCare', 'location': 'Bangalore'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: serviceCenters.length,
      itemBuilder: (context, index) {
        final center = serviceCenters[index];
        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            leading: Icon(Icons.location_pin, color: Colors.green),
            title: Text(center['name']!),
            subtitle: Text('Location: ${center['location']}'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Navigate to more details if required
            },
          ),
        );
      },
    );
  }
}

class SparesView extends StatelessWidget {
  final List<Map<String, String>> spares = [
    {'name': 'Battery Pack', 'price': '₹20,000'},
    {'name': 'Charging Cable', 'price': '₹1,500'},
    {'name': 'Brake Pads', 'price': '₹500'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: spares.length,
      itemBuilder: (context, index) {
        final spare = spares[index];
        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            leading: Icon(Icons.build_circle, color: Colors.blue),
            title: Text(spare['name']!),
            subtitle: Text('Price: ${spare['price']}'),
            trailing: Icon(Icons.add_shopping_cart),
            onTap: () {
              // Add to cart or view details
            },
          ),
        );
      },
    );
  }
}
