import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class DoctorDatabase {
  post(
      String id,
      String email,
      String address,
      String firstName,
      String lastName,
      String birthday,
      String master,
      String hospital,
      String gender,
      String phoneNumber,
      String profileImage) async {
    var url = Uri.parse('http://roshetta1.pythonanywhere.com/doctor');
    var body = json.encode({
      "email": email,
      "address": address,
      "birthday": birthday,
      "firstName": firstName,
      "master": master,
      "hospital": hospital,
      "gender": gender,
      "id": id,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "profileImage": profileImage,
    });

    final response = await http.post(url,
        headers: {HttpHeaders.CONTENT_TYPE: "application/json"}, body: body);

    print('Post Status code: ${response.statusCode}');
    print('Post Body: ${response.body}');

    return response.body;
  }

  delete(String id) async {
    var url = Uri.parse('http://roshetta1.pythonanywhere.com/doctors/id=$id');
    final http.Response response = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print('Delete Status code: ${response.statusCode}');
    print('Delete Body: ${response.body}');

    return response;
  }
}
