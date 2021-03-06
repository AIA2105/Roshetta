import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'package:roshetta/Constants/Links.dart';
import 'package:roshetta/Constants/Methods.dart';
import 'Patient.dart';


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
      File profileImage,
      String state,
      String weight) async {

     var pic;
     File f = await Methods.getImageFileFromAssets('images/newPatient.png','newPatient.png');
     //create multipart request for POST or PATCH method
    var request = http.MultipartRequest("POST", Uri.parse(Links().patient));
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

    print(response.statusCode);
    print(responseString);
    return responseString;
  }

  update(
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
    var request = http.MultipartRequest("PUT", Uri.parse("${Links().patient}/id=$id"));
    //add text fields
    request.fields["email"]= email;
    request.fields["address"]= address;
    request.fields["blood"]= blood;
    request.fields["DOB"]= dateOfBirth;
    request.fields["f_name"]= firstName;
    request.fields["gender"]= gender;
    request.fields["height"]= height;
    request.fields["l_name"]= lastName;
    request.fields["phoneNumber"]= phoneNumber;
    request.fields["state"]= state;
    request.fields["weight"]= weight;

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
    var url = Uri.parse('${Links().patient}s/id=$id');
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
    var url = Uri.parse('${Links().patient}/id=$id');
    var response = await http.get(url);
    var patientData = List<Patient>();
    if (response.statusCode == 200) {
      var patientJson = json.decode(utf8.decode(response.bodyBytes));
      for (var json in patientJson) {
        patientData.add(Patient.fromJson(json));
      }
    }
    print('Patient Data get Successful');
    return patientData[0];
  }

   dashboard(String id) async {
     var request = http.MultipartRequest("GET", Uri.parse('${Links().patientDashboard}/id=$id'));
     var response = await request.send();
     var responseData = await response.stream.toBytes();
     var responseString = String.fromCharCodes(responseData);
     print('Patient dashboard get successful');
     return responseString;
   }

   notification(String id) async {
     var request = http.MultipartRequest("GET", Uri.parse('${Links().patientNotification}/id=$id'));
     var response = await request.send();
     var responseData = await response.stream.toBytes();
     var responseString = String.fromCharCodes(responseData);
     print('Patient notification= $responseString');
     return responseString;
   }

}