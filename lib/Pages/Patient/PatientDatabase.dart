import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';



class PatientDatabase {

  post(
      String email,
      String address,
      String blood,
      String dateOfBirth,
      String firstName,
      String lastName,
      String gender,
      String height,
      String id,
      String phoneNumber,
      String profileImage,
      String state,
      String weight) async {
    var url = Uri.parse('http://roshetta1.pythonanywhere.com/patient');
    var body = json.encode({
      "email": email,
      "address": address,
      "blood": blood,
      "DOB": dateOfBirth,
      "f_name": firstName,
      "gender": gender,
      "height": height,
      "id": id,
      "l_name": lastName,
      "phoneNumber": phoneNumber,
      "profileImage": profileImage,
      "state": state,
      "weight": weight
    });

    final response = await http.post(url,
        headers: {HttpHeaders.CONTENT_TYPE: "application/json"}, body: body);

    print('Post Status code: ${response.statusCode}');
    print('Post Body: ${response.body}');

    return response.body;
  }

  delete(String id) async {
    var url = Uri.parse('http://roshetta1.pythonanywhere.com/patients/id=$id');
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
