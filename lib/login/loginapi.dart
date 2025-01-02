import 'package:electra_wheels/services/user/getProfile.dart';
import 'package:electra_wheels/user/userhomepage.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
Map<String,dynamic> profiedata={};
String baseurl = 'http://192.168.1.154:5000';
int? lid;
String? userType;
String? loginStatus;

Future<void> loginApi(
    String username, String password, BuildContext context) async {
  try {
    // Prepare the URI with query parameters
    final uri = Uri.parse('$baseurl/LoginPageApi',);

    // Perform the POST request
    final response = await http.post(uri,body:{
      'email' : username,
      'password' : password
    });

    // Check the status code and response data
    print(response.body);
    int statusCode = response.statusCode;
    print('Status code: $statusCode');
    // Decode the JSON response
    final data = json.decode(response.body);

    loginStatus = data['message'] ?? 'failed';

    if (statusCode == 200 && loginStatus == 'success') {
      userType = data['Type'];
      lid = data['login_id'];
     profiedata=await getProfileApi();
      // Navigate based on userType
      if (userType == 'user') {
        Navigator.pushReplacement(
          context,
        MaterialPageRoute(builder: (ctx) => Userhomepage()),
        );
      } else if (userType == 'station') {
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (ctx) => UserHomePage()),
        // );
        } else if (userType == 'center') {
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (ctx) => Doctorhomepage()),
        // );
      } else {
        // Handle unknown userType
        print('Unknown userType: $userType');
      }
    } else {
      print('Login failed: $loginStatus');
    }
  } catch (e) {
    print('Error during login: $e');
  }

}

