import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testing/models/loginmodel.dart';
import 'package:testing/models/fetchmodel.dart';

class ApiService {
  Future<http.Response> fetchData(int branchid) async {
    var url = Uri.parse(
        'https://admin.cherryberryrms.com/v2/api/onlineapp/get_main_data?restaurant_branch_id=$branchid&order_resource_id=1');
    var response = await http.get(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final decodedData = jsonDecode(response.body);
      final loginResponse = FetchModel.fromJson(decodedData);
      return response;
    } else {
      print('Error: ${response.statusCode}, ${response.body}');
      throw Exception(
          'Failed to Create Data: ${response.statusCode}\n${response.body}');
    }
  }

  Future<http.Response> LoginCheck(
    String emailController,
    String passwordController,
  ) async {
    var url =
        Uri.parse('https://admin.cherryberryrms.com/v2/api/onlineapp/login');

    String responseBody = json.encode({
      "email": emailController,
      "password": passwordController,
      "restaurant_id": 1236,
      "order_resource_id": 3,
      "device_id": 123,
    });

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: responseBody);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final decodedData = jsonDecode(response.body);
      final loginResponse = LoginModel.fromJson(decodedData);
      return response;
    } else {
      print('Error: ${response.statusCode}, ${response.body}');
      throw Exception(
          'Failed to Create Data: ${response.statusCode}\n${response.body}');
    }
  }

  Future<String> deleteData(int number) async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/$number');
    var response = await http.delete(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return 'Data Deleted';
    } else {
      return 'Failed to Delete Data';
    }
  }
}
