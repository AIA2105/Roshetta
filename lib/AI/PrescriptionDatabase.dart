import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:roshetta/Constants/Links.dart';

class PrescriptionDatabase {
  String _finalResult;

  Future<String> postPrescription(String id, File image) async {
    //create multipart request for POST or PATCH method
    var request =
        http.MultipartRequest("POST", Uri.parse(Links().prescription));
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
    _finalResult = responseString;
    print(_finalResult);

    if (!_finalResult.contains('Tunnel') &&
        !_finalResult.contains('.ngrok.io not found') &&
        !_finalResult.contains('<title>500 Internal Server Error</title>') &&
        _finalResult != 'Error') {
      return _finalResult;
    } else {
      return 'AI Server is Off';
    }
  }
}
