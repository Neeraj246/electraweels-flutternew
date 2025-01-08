import 'package:electra_wheels/login/register.dart';
import 'package:electra_wheels/login/servicereg.dart';
import 'package:electra_wheels/login/stationreg.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Stack(
        children: [
          Container(
            child: Image.asset(
              "assets/pic1.png",
              fit: BoxFit.fill,height: double.infinity,
            ),
          ),        Center(
          child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Registration',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                   Navigator.push(
          context,
        MaterialPageRoute(builder: (ctx) => Register()));
                  // Handle registration logic here
                },
                child: Text('USER'),
                style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 85),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: const Color.fromARGB(255, 215, 217, 222),
                            ),
              ),
               SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                   Navigator.push(
          context,
        MaterialPageRoute(builder: (ctx) => Stationreg()));
                  // Handle registration logic here
                },
                child: Text('STATION'),
                style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 75),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: const Color.fromARGB(255, 215, 217, 222),
                            ),
              ),
               SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                    Navigator.push(
          context,
        MaterialPageRoute(builder: (ctx) => Servicereg()));
                  // Handle registration logic here
                },
                child: Text('SERVICE CENTER'),
                style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: const Color.fromARGB(255, 215, 217, 222),
                            ),
              ),
            ],
          ),
                ),
        )
        ],
    )
    );
  }
}