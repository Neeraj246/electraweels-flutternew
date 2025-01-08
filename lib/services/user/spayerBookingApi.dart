import 'package:dio/dio.dart';
import 'package:electra_wheels/login/loginapi.dart';
import 'package:flutter/material.dart';

final dio = Dio();


Future<Map<String, dynamic>> BookSpayerApi(Map<String, dynamic>data,context) async {
  try {
    final response = await dio.get('$baseurl/Bookspare', data: data);
    print("qqqqqqqqqqqqqqqqqq${response.data}");
    
    if (response.statusCode == 200) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('booking Success')));
      return response.data;
    } else {
      throw Exception('Failed to submit complaint');
    }
  } catch (e) {
    throw Exception('API Error: $e');
  }
}


