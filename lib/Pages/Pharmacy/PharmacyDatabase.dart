import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'Pharmacy.dart';

class PharmacyDatabase {

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
      String pharmacyName,
      String firstName,
      String lastName,
      String delivery,
      String workHours,
      String phoneNumber,
      File profileImage) async {

    var pic;
    File f = await getImageFileFromAssets('images/newPharmacy.png','newPharmacy.png');
    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest("POST", Uri.parse("http://roshetta1.pythonanywhere.com/pharmacist"));
    //add text fields
    request.fields["email"]= email;
    request.fields["address"]= address;
    request.fields["pharmacyName"]= pharmacyName;
    request.fields["delivery"]= delivery;
    request.fields["firstName"]= firstName;
    request.fields["workHours"]= workHours;
    request.fields["id"]= id;
    request.fields["lastName"]= lastName;
    request.fields["phoneNumber"]= phoneNumber;


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
      String pharmacyName,
      String firstName,
      String lastName,
      String delivery,
      String workHours,
      String phoneNumber,
      File profileImage) async {

    var pic;
    var request = http.MultipartRequest("PUT", Uri.parse("http://roshetta1.pythonanywhere.com/pharmacist/id=$id"));
    //add text fields
    request.fields["email"]= email;
    request.fields["address"]= address;
    request.fields["pharmacyName"]= pharmacyName;
    request.fields["delivery"]= delivery;
    request.fields["firstName"]= firstName;
    request.fields["workHours"]= workHours;
    request.fields["lastName"]= lastName;
    request.fields["phoneNumber"]= phoneNumber;

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
    var url = Uri.parse('http://roshetta1.pythonanywhere.com/pharmacists/id=$id');
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

  Future<Pharmacy> get(String id) async {
    var url = Uri.parse('http://roshetta1.pythonanywhere.com/pharmacist/id=$id');
    var response = await http.get(url);
    var pharmacyData = List<Pharmacy>();
    if (response.statusCode == 200) {
      var pharmacyJson = json.decode(utf8.decode(response.bodyBytes));
      for (var json in pharmacyJson) {
        pharmacyData.add(Pharmacy.fromJson(json));
      }
    }
    return pharmacyData[0];
  }

}
