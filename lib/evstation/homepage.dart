import 'package:electra_wheels/evstation/manageslot.dart';
import 'package:electra_wheels/evstation/viewreviews.dart';
import 'package:electra_wheels/login/loginpage.dart';
import 'package:flutter/material.dart';

class EVStationHomePage extends StatelessWidget {
  const EVStationHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EV Station',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: const Color.fromARGB(255, 223, 237, 224),
        elevation: 4,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            // Drawer header
            UserAccountsDrawerHeader(
              accountName: const Text(
                "abc",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              accountEmail: const Text("abc@example.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.greenAccent,
                child: const Icon(Icons.person, size: 50, color: Colors.white),
              ),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 33, 58, 34),
              ),
            ),
            // View My Profile
      
            const Divider(),
            // Logout
           ListTile(
  leading: const Icon(Icons.logout, color: Colors.redAccent),
  title: const Text("Logout"),
  onTap: () {
    Navigator.pop(context); // Close the drawer
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close dialog
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Loginpage()),
              ); // Navigate to LogoutPage
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  },
),

          ],
        ),
      ),
      body: Stack(
        children: [
          // Background image with gradient overlay
          Container(
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("assets/ev_station_bg.jpg"),
                fit: BoxFit.cover,
              ),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.green.withOpacity(0.3),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Semi-transparent overlay
          Container(
            color: Colors.black.withOpacity(0.4),
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App logo with glow effect
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  child: const Icon(
                    Icons.ev_station,
                    size: 60,
                    color: Colors.greenAccent,
                  ),
                ),
                const SizedBox(height: 20),
                // Title with shadow
                const Text(
                  "EV Station ",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 4),
                        blurRadius: 8,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                // Buttons aligned vertically
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildFeatureButton(
                        context,
                        "Manage Slot",
                        Icons.schedule,
                        const LinearGradient(
                          colors: [Colors.green, Colors.lightGreen],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ManageSlotPage(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildFeatureButton(
                        context,
                        "Reviews & Complaints",
                        Icons.feedback,
                        const LinearGradient(
                          colors: [Colors.blue, Colors.lightBlueAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReviewsAndComplaintsPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Method to build individual feature buttons
  Widget _buildFeatureButton(
    BuildContext context,
    String title,
    IconData icon,
    Gradient gradient,
    VoidCallback onPressed,
  ) {
    return InkWell(
      onTap: onPressed,
      splashColor: Colors.white.withOpacity(0.2),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: gradient,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


