import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'package:roshetta/Constants/Links.dart';
import 'package:roshetta/Constants/Methods.dart';
import 'Doctor.dart';

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
      File profileImage) async {

    var pic;
    File f = await Methods.getImageFileFromAssets('images/newDoctor.png','newDoctor.png');
    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest("POST", Uri.parse(Links().doctor));
    //add text fields
    request.fields["email"]= email;
    request.fields["address"]= address;
    request.fields["birthday"]= birthday;
    request.fields["firstName"]= firstName;
    request.fields["gender"]= gender;
    request.fields["id"]= id;
    request.fields["lastName"]= lastName;
    request.fields["phoneNumber"]= phoneNumber;
    request.fields["master"]= master;
    request.fields["hospital"]= hospital;

    //create multipart using filepath, string or bytes
    if(profileImage==null){
      pic = await http.MultipartFile.fromPath("profileImage", f.path);
    }else{
      pic = await http.MultipartFile.fromPath("profileImage", profileImage.path);
    }

    //add multipart to request
    request.files.add(pic);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
  }

  update(
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
      File profileImage) async {

    var pic;
    var request = http.MultipartRequest("PUT", Uri.parse("${Links().doctor}/id=$id"));
    //add text fields
    request.fields["email"]= email;
    request.fields["address"]= address;
    request.fields["birthday"]= birthday;
    request.fields["firstName"]= firstName;
    request.fields["gender"]= gender;
    request.fields["lastName"]= lastName;
    request.fields["phoneNumber"]= phoneNumber;
    request.fields["master"]= master;
    request.fields["hospital"]= hospital;

    //create multipart using filepath, string or bytes
    pic = await http.MultipartFile.fromPath("profileImage", profileImage.path);

    //add multipart to request
    request.files.add(pic);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    print(response.statusCode);
    print(responseString);

    return responseString;
  }

  delete(String id) async {
    var url = Uri.parse('${Links().doctor}s/id=$id');
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

  Future<Doctor> get(String id) async {
    var url = Uri.parse('${Links().doctor}/id=$id');
    var response = await http.get(url);
    var doctorData = List<Doctor>();
    if (response.statusCode == 200) {
      var doctorJson = json.decode(utf8.decode(response.bodyBytes));
      for (var json in doctorJson) {
        doctorData.add(Doctor.fromJson(json));
      }
    }
    return doctorData[0];
  }

}
