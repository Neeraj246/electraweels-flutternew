import 'package:dio/dio.dart';
import 'package:electra_wheels/login/loginapi.dart';

final dio = Dio();
int? comres;
int? subres;

Future<Map<String, dynamic>> submitComplaint(Map<String, dynamic>data) async {
  try {
    final response = await dio.post('$baseurl/Addcomplaint', data: {
      "Description": data['complaint'],
      "Complaint": data['title'],
      "Category":data['category'],
      "USER": lid,
    });
    print("qqqqqqqqqqqqqqqqqq${response.data}");
    subres = response.statusCode;
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to submit complaint');
    }
  } catch (e) {
    throw Exception('API Error: $e');
  }
}

Future<List<Map<String, dynamic>>> fetchComplaints() async {
  try {
    final Response response = await dio.get('$baseurl/ViewComplaint/$lid');
    print(response.data);  // Log the data to see the structure
    comres=response.statusCode;
    if (response.statusCode == 200) {
      // Successfully fetched complaints
      return List<Map<String, dynamic>>.from(response.data);
    } else {
      // Handle unexpected status codes
      throw Exception(
          'Failed to fetch complaints. Status code: ${response.statusCode}');
    }
  } on DioException catch (e) {
    // Handle DioException and network errors
    if (e.response != null) {
      // Server error
      print(
          'Server error: ${e.response?.statusCode}, ${e.response?.data}');
    } else {
      // Network error (e.g., no internet connection)
      print('Network error: ${e.message}');
    }
    // Return an empty list in case of error
    return [];
  } catch (e) {
    // Handle any other types of errors
    print('Unexpected error: $e');
    return [];
  }
}

