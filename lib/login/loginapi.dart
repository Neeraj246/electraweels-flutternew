import 'package:dio/dio.dart';
import 'package:electra_wheels/user/getProfile.dart';
import 'package:electra_wheels/user/userhomepage.dart';
import 'package:flutter/material.dart';

Map<String,dynamic> profiedata={};
String baseurl ='http://192.168.1.101:5000';
int? lid;
String? userType;
String? loginStatus;
Dio _dio =Dio();

Future<void> loginApi(
    String username, String password, BuildContext context) async {
  try {
    // Prepare the URI with query parameters
    // final uri = Uri.parse('$baseurl/LoginPageApi',);

    // Perform the POST request
    final response = await _dio.post('$baseurl/LoginPageApi',data:{
      'username' : username,
      'password' : password
    });

    // Check the status code and response data
    print(response.data);
    int statusCode = response.statusCode!;
    print('Status code: $statusCode');
    // Decode the JSON response
    final data = response.data;

    loginStatus = data['message'] ?? 'failed';

    if (statusCode == 200 ) {
      userType = data['Type'];
      lid = data['login_id'];
     profiedata=await getProfileApi();
      // Navigate based on userType
      if (userType == 'USER') {
        print("^^^^^^^^^^^^^^^^^");
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

