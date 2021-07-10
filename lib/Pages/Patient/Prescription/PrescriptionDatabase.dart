import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'package:roshetta/Constants/Links.dart';
import 'package:roshetta/Pages/Patient/Prescription/DigitalPrescription.dart';
import 'package:roshetta/Pages/Patient/Prescription/LocalPrescription.dart';


class PrescriptionDatabase {


  postLocal(String patientID,
      String doctorName,
      String master,
      String date,
      File image,) async {

    var pic;
    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest("POST", Uri.parse(Links().addLocalPrescription));
    //add text fields
    request.fields["patient_id"] = patientID;
    request.fields["otherDoctorName"] = doctorName;
    request.fields["classification"] = master;
    request.fields["date"] = date;

    //create multipart using filepath, string or bytes
      pic = await http.MultipartFile.fromPath("image", image.path);

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


  Future<List<LocalPrescription>> getLocal(String id) async {
    var url = Uri.parse('${Links().localPrescription}/patientid=$id');
    var response = await http.get(url);
    var prescriptionData = List<LocalPrescription>();
    if (response.statusCode == 200) {
      var patientJson = json.decode(utf8.decode(response.bodyBytes));
      for (var json in patientJson) {
        prescriptionData.add(LocalPrescription.fromJson(json));
      }
    }
    return prescriptionData;
  }

  Future<List<DigitalPrescription>> getDigital(String id) async {
    var url = Uri.parse('${Links().digitalPrescription}/patientid=$id');
    var response = await http.get(url);
    var prescriptionData = List<DigitalPrescription>();
    if (response.statusCode == 200) {
      var patientJson = json.decode(utf8.decode(response.bodyBytes));
      for (var json in patientJson) {
        prescriptionData.add(DigitalPrescription.fromJson(json));
      }
    }
    return prescriptionData;
  }


  Future<List<LocalPrescription>> searchLocal(String name, String patientId) async {
    var url = Uri.parse('${Links().main}/patientPrescriptionOtherDoctorName/patientId=$patientId/otherDoctorName=$name');
    var response = await http.get(url);
    var prescriptionData = List<LocalPrescription>();
    if (response.statusCode == 200) {
      var patientJson = json.decode(utf8.decode(response.bodyBytes));
      for (var json in patientJson) {
        prescriptionData.add(LocalPrescription.fromJson(json));
      }
    }
    return prescriptionData;
  }

  Future<List<DigitalPrescription>> searchDigital(String name, String patientId) async {
    var url = Uri.parse('${Links().main}/patientDigitalPrescriptionDoctorName/patientId=$patientId/doctorName=$name');
    var response = await http.get(url);
    var prescriptionData = List<DigitalPrescription>();
    if (response.statusCode == 200) {
      var patientJson = json.decode(utf8.decode(response.bodyBytes));
      for (var json in patientJson) {
        prescriptionData.add(DigitalPrescription.fromJson(json));
      }
    }
    return prescriptionData;
  }

  Future<List<LocalPrescription>> filterLocal(String filter, String patientId) async {
    var url = Uri.parse('${Links().main}/patientPrescriptionClassfication/patientId=$patientId/classification=$filter');
    var response = await http.get(url);
    var prescriptionData = List<LocalPrescription>();
    if (response.statusCode == 200) {
      var patientJson = json.decode(utf8.decode(response.bodyBytes));
      for (var json in patientJson) {
        prescriptionData.add(LocalPrescription.fromJson(json));
      }
    }
    return prescriptionData;
  }

  Future<List<DigitalPrescription>> filterDigital(String filter, String patientId) async {
    var url = Uri.parse('${Links().main}/patientDigitalPrescriptionMaster/patientId=$patientId/master=$filter');
    var response = await http.get(url);
    var prescriptionData = List<DigitalPrescription>();
    if (response.statusCode == 200) {
      var patientJson = json.decode(utf8.decode(response.bodyBytes));
      for (var json in patientJson) {
        prescriptionData.add(DigitalPrescription.fromJson(json));
      }
    }
    return prescriptionData;
  }

}