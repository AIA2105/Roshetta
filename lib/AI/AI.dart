import 'package:http/http.dart' as http;
import 'dart:io';

class AI{
  String _finalResult;

  Future<String> postPrescription(String id, File image) async {

    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest("POST", Uri.parse("http://roshetta1.pythonanywhere.com/prescription"));
    //add text fields
    request.fields["patient_id"] = id;
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("image", image.path);
    //add multipart to request
    request.files.add(pic);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    _finalResult= responseString;
    print(_finalResult);
    return _finalResult;
  }


}