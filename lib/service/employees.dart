import 'dart:convert';

import 'package:example/model/employee.dart';
import 'package:http/http.dart' as http;

String hostUrl = "https://example-s8ge.onrender.com/user";

class EmployeeData {
  Future addEmployee(var body) async {
    var url = Uri.parse("$hostUrl/addEmployee");
    print("EMployee Data--> $body");
    http.Response response =
        await http.post(url, body: body, headers: {'type': 'application/json'});
    print("Employee Data--> ${response.body}");
    if (response.statusCode == 200) {
      var extractedData = jsonDecode(response.body);

      return extractedData;
    } else {
      throw Exception("Unexpected Error");
    }
  }

  Future<List<EmployeeDetails>> getEmployee() async {
    var url = Uri.parse("$hostUrl/getData");
    http.Response response = await http.get(url);
    print("Employee Data--> ${response.body}");

    if (response.statusCode == 200) {
      List extractedData = jsonDecode(response.body);
      return extractedData
          .map((data) => EmployeeDetails.fromJson(data))
          .toList();
    } else {
      throw Exception("Unexpected Error");
    }
  }
}
