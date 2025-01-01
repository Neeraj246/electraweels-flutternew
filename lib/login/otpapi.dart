// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';


// String baseurl = 'http://192.168.1.12:5000';
// final dio = Dio();
// String? status_otp;

// Future<void> otpApi( otp,orgundata,context) async {
//   try {
//     final response = await dio.post('$baseurl/otp?lid=$lid&otp=$otp');
//     print(response.data);
//     int? res = response.statusCode;
//     print(res);
//     status_otp = response.data['status'] ?? 'failed';
//     if (res == 200 && response.data['status'] == 'success') {
//       print("Success");
//            ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('OTP Verified')),
//                   );
//       //addorganApi(orgundata,context);

//     } else {
//       print('Failed');
//     }
//   } catch (e) {
//     print('Error: $e');
//   }
// }
