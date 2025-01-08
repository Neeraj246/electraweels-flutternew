import 'package:electra_wheels/login/loginapi.dart';
import 'package:electra_wheels/user/spayerBookingScreen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceAndSparesScreen extends StatelessWidget {
  const ServiceAndSparesScreen({super.key, this.sericeSenters, this.spayers});
  final sericeSenters;
  final spayers;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 33, 58, 34),
          title: Text(
            'ElectraWheels - Services & Spares',
            style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Service Centers', icon: Icon(Icons.build)),
              Tab(text: 'Spares', icon: Icon(Icons.settings)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ServiceCentersView(sericeSenters: sericeSenters,),
            SparesView(spayers: spayers,),
          ],
        ),
      ),
    );
  }
}

class ServiceCentersView extends StatelessWidget {
  ServiceCentersView({super.key, this.sericeSenters, this.spayers});
  final sericeSenters;
  final spayers;


   Future<void> openMap(double latitude, double longitude) async {
    final String googleMapsUrl = "https://www.google.com/maps/search/?q=$latitude,$longitude";
    

    // Check if Google Maps is available, and open it if possible
    // if (await canLaunch(googleMapsUrl)) {
      await launchUrl(Uri.parse(googleMapsUrl));
    // }
    // else {
    //   throw 'Could not launch maps.';
    // }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sericeSenters.length,
      itemBuilder: (context, index) {
        final center = sericeSenters[index];
        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            leading: Icon(Icons.location_pin, color: Colors.green),
            title: Text(center['Name']!),
            subtitle: Text('Location: ${center['Address']}'),
            trailing: Icon(Icons.arrow_forward),
            onTap: ()async {
await openMap(11.226391,75.803857);
              // Navigate to more details if required
            },
          ),
        );
      },
    );
  }
}

class SparesView extends StatelessWidget {
  const SparesView({super.key, this.sericeSenters, this.spayers});
  final sericeSenters;
  final spayers;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: spayers.length,
      itemBuilder: (context, index) {
        final spare = spayers[index];
        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            leading:spare['image']!=null?CircleAvatar(backgroundImage: NetworkImage('$baseurl/${spare['image']!}'),)  : Icon(Icons.build_circle, color: Colors.blue),
            title: Text(spare['Name']!),
            subtitle: Text('Price: ${spare['Amount']}'),
            trailing: Icon(Icons.book_online_outlined),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (ctxt)=>BookingScreen(itemdata: spare,)));
              
              // Add to cart or view details
            },
          ),
        );
      },
    );
  }
}
