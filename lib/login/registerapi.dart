//api post


//api post

import 'package:dio/dio.dart';
import 'package:electra_wheels/login/loginapi.dart';
import 'package:electra_wheels/login/loginpage.dart';
import 'package:flutter/material.dart';

final dio = Dio();

Future<void> registrationdataApi(data,context) async {
  try {
    Response response =
        await dio.post('$baseurl/UserReg', data: data);
    print(response);
    print(response.statusCode);
    if (response.statusCode == 200||response.statusCode==201) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Loginpage()));
            ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration Successful')),
      );

      print("success");
      // List<dynamic> products = response.data;
      // List<Map<String, dynamic>> listdata =
      //     List<Map<String, dynamic>>.from(products);
      // return listdata;
    } else {
      throw Exception('failed to get');
    }
  } catch (e) {
    print(e.toString());
    // return [];
  }
}