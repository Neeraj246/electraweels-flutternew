import 'package:electra_wheels/login/loginapi.dart';
import 'package:electra_wheels/user/userhomepage.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';



Future<void> sendComplaintApi(
      context,Map datas) async {
  try {
    // Prepare the URI with query parameters
    final uri = Uri.parse('$baseurl/LoginPageApi',);

    // Perform the POST request
    final response = await http.post(uri,body:datas);

    // Check the status code and response data
    print(response.body);
    int statusCode = response.statusCode;
    print('Status code: $statusCode');
    // Decode the JSON response
    final data = json.decode(response.body);

   

    if (statusCode == 200) {
     
   
    } else {
      print('Login failed: $loginStatus');
    }
  } catch (e) {
    print('Error during login: $e');
  }

}

