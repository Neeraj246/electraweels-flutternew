//api post


//api post

import 'package:dio/dio.dart';

final dio = Dio();

Future<void> userapi(data) async {
  try {
    Response response =
        await dio.post('http://192.168.1.12:5000/user', data: data);
    print(response);
    print(response.statusCode);
    if (response.statusCode == 200) {
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