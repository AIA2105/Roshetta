
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roshetta/AI/AI.dart';
import 'dart:io';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/AI/AIScreen.dart';
import '../Constants/Spaces.dart';
import '../Widgets/Widgets.dart';

class Camera extends StatefulWidget {

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File _image;
  final picker = ImagePicker();
  String finalResult;
  Widget progress= Text(
      'تحليل الصورة',
      style: TextStyle(
          color: Colors.white,
          fontFamily: 'arabic',
          fontSize: 22)
  );


  Future getCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future getGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState((){
      _image = File(pickedFile.path);
      print('Image: $_image');
      print('Image path: ${_image.path}');
      print('Image URI: ${_image.uri}');
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Pallet().background_R,
      appBar:  AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Pallet().blue_R,
              size: Spaces().backButton,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Pallet().background_R,
          title: Widgets().arabicText(
              text: 'اختيار صورة',
              fontSize: Spaces().bigTitleSize,
              color: Pallet().blue_R)),
      body: Column(
        children: [
          Expanded(
              child: Center(
            child: _image == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Opacity(
                        opacity: 0.5,
                        child: Icon(
                          Icons.photo_camera,
                          size: 50,
                        ),
                      ),
                      Text(
                        'احرص على وضوح اسم الدواء',
                        style: TextStyle(
                            color: Colors.black26,
                            fontFamily: 'arabic',
                            fontSize: 22),
                      ),
                    ],
                  )

                : Image.file(_image),

          )),
          if (_image == null)
            Row(
              children: [
                Expanded(
                    child: FlatButton(
                  onPressed: getCamera,
                  child: Text('اختار من الكاميرا',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'arabic',
                          fontSize: 22)),
                  color: Pallet().blue_R,
                  padding: EdgeInsets.all(15),
                )),
                Expanded(
                    child: FlatButton(
                  onPressed: getGallery,
                  child: Text('اختار من المعرض', style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'arabic',
                      fontSize: 22)),
                  color: Pallet().red_R,
                  padding: EdgeInsets.all(15),
                )),
              ],
            )
          else
            Container(
                width: double.infinity,
                child: FlatButton(
                  onPressed: () async{
                    setState(() {
                      progress= CircularProgressIndicator(color: Pallet().white_R,);
                    });
                    String result= await AI().postPrescription(FirebaseAuth.instance.currentUser.uid, _image);
                    finalResult= result;
                    if(finalResult!='AI Server is Off'){
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => AIScreen(result: finalResult)));
                    }else{
                      setState(() {
                        progress=Text(
                            'السيرفر غير متاح الآن',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'arabic',
                                fontSize: 22)
                        );
                      });
                    }



                  },
                  child: progress,
                  color: Pallet().red_R,
                  padding: EdgeInsets.all(15),
                )),
        ],
      ),
    );
  }
}
