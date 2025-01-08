import 'dart:async';
import 'package:electra_wheels/login/loginpage.dart';
import 'package:electra_wheels/services/user/getBookingHistory.dart';
import 'package:electra_wheels/services/user/getStationBookingHistory.dart';
import 'package:electra_wheels/user/chargingstdetails.dart';
import 'package:electra_wheels/user/complaint.dart';
import 'package:electra_wheels/user/complaint_page.dart';
import 'package:electra_wheels/user/feedback.dart';
import 'package:electra_wheels/user/getSpayers.dart';
import 'package:electra_wheels/user/getservicestations.dart';
import 'package:electra_wheels/user/slotbookingHistory.dart';
import 'package:electra_wheels/user/viewSpayerBookingHistory.dart';
import 'package:electra_wheels/user/viewservice.dart';
import 'package:flutter/material.dart';

class Userhomepage extends StatefulWidget {
  @override
  _UserhomepageState createState() => _UserhomepageState();
}

class _UserhomepageState extends State<Userhomepage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 33, 58, 34),
      ),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Auto-scrollable image carousel with decoration
            Container(
              height: 200,
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  children: [
                    Image.asset(
                      'assets/car.jpeg',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'assets/ev2.png',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'assets/ev3.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),

            // Dots Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0),
                  width: _currentPage == index ? 12.0 : 8.0,
                  height: _currentPage == index ? 12.0 : 8.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index ? Colors.green : Colors.grey,
                  ),
                );
              }),
            ),

            // Farming Quote
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '"In order to have clean air in cities, you have to go electric "',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.green.shade800,
                ),
              ),
            ),

            // GridView for functionalities
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildGridItem(
                    context,
                    'Search stations',
                    Icons.ev_station,
                    Colors.blueAccent,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NearbyLocationsScreen()),
                      );
                    },
                  ),
                  _buildGridItem(
                    context,
                    'Service centres',
                    Icons.settings,
                    Colors.cyanAccent,
                    () async {
                      List<Map<String, dynamic>> serviceStations =
                          await getserviceStationsApi();
                      List<Map<String, dynamic>> serviceSpayers =
                          await getSpayersApi();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ServiceAndSparesScreen(
                                  sericeSenters: serviceStations,
                                  spayers: serviceSpayers,
                                )),
                      );
                    },
                  ),
                  _buildGridItem(
                    context,
                    'Feedback',
                    Icons.rate_review,
                    Colors.orangeAccent,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddReviewScreen()),
                      );
                    },
                  ),
                  _buildGridItem(
                    context,
                    'Complaint Registration',
                    Icons.warning,
                    const Color.fromARGB(255, 145, 171, 0),
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ComplaintPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Drawer widget with View My Donation, Add Organ Request, and Sign Out
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 250,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assests/profile.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'user',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'user@gmail.com',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text('Bookings'),
            leading: Icon(Icons.history),
            onTap: ()async {
              List<Map<String,dynamic>>history=await getstationBokingHistoryApi();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SlotBookingHistoryScreen(bookingHistory: history,)));
            },
          ),


           ListTile(
            title: Text('Spare Booking '),
            leading: Icon(Icons.history),
            onTap: ()async {
              List<Map<String,dynamic>>history=await getspayerBokingHistoryApi();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookingHistoryScreen(bookingHistory: history,)));
            },
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: IconButton(
              icon: Icon(Icons.logout_outlined),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Loginpage()),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logout success')),
                );
              },
              child: Text('Sign Out',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create a grid item
  Widget _buildGridItem(BuildContext context, String title, IconData icon,
      Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: color,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: Colors.white),
              SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
