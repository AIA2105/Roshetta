import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'Doctor.dart';

class DoctorDatabase {

  Future<File> getImageFileFromAssets(String path,String tmp) async {
    final byteData = await rootBundle.load(path);
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/$tmp');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }

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
    File f = await getImageFileFromAssets('images/newDoctor.png','newDoctor.png');
    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest("POST", Uri.parse("http://roshetta1.pythonanywhere.com/doctor"));
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

  Future<Doctor> get(String id) async {
    var url = Uri.parse('http://roshetta1.pythonanywhere.com/doctor/id=$id');
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
