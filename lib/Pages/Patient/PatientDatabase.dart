import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'Patient.dart';


class PatientDatabase {
  Future<File> getImageFileFromAssets(String path,String tmp) async {
    final byteData = await rootBundle.load(path);
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/$tmp');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }


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
      File profileImage,
      String state,
      String weight) async {

     var pic;
     File f = await getImageFileFromAssets('images/newPatient.png','newPatient.png');
     //create multipart request for POST or PATCH method
    var request = http.MultipartRequest("POST", Uri.parse("http://roshetta1.pythonanywhere.com/patient"));
    //add text fields
    request.fields["email"]= email;
    request.fields["address"]= address;
    request.fields["blood"]= blood;
    request.fields["DOB"]= dateOfBirth;
    request.fields["f_name"]= firstName;
    request.fields["gender"]= gender;
    request.fields["height"]= height;
    request.fields["id"]= id;
    request.fields["l_name"]= lastName;
    request.fields["phoneNumber"]= phoneNumber;
    request.fields["state"]= state;
    request.fields["weight"]= weight;

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

  Future<Patient> get(String id) async {
    var url = Uri.parse('http://roshetta1.pythonanywhere.com/patient/id=$id');
    var response = await http.get(url);
    var patientData = List<Patient>();
    if (response.statusCode == 200) {
      var patientJson = json.decode(utf8.decode(response.bodyBytes));
      for (var json in patientJson) {
        patientData.add(Patient.fromJson(json));
      }
    }
    return patientData[0];
  }
}
