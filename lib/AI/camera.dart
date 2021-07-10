import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roshetta/AI/ScanPrescription.dart';
import 'dart:io';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/AI/AIResultScreen.dart';
import 'package:roshetta/Pages/Patient/PatientHomeScreen.dart';
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
  Widget progress= Widgets().arabicText(
  text: 'تحليل الصورة',
  fontSize:Spaces().bigTitleSize,
  color: Pallet().white_R,
  );

  Future getCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    _image = File(pickedFile.path);
    cropImage();
  }

  Future getGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    _image = File(pickedFile.path);
    cropImage();
  }

  cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
        ],
        androidUiSettings: AndroidUiSettings(
          lockAspectRatio: false,
          toolbarTitle: 'قص السطر المراد تحليله',
          toolbarColor: Pallet().blue_R,
          toolbarWidgetColor: Pallet().white_R,
          initAspectRatio: CropAspectRatioPreset.original,
          activeControlsWidgetColor: Pallet().red_R,
          backgroundColor: Pallet().white_R,
        ));
    if (croppedFile != null) {
      setState(() {
        _image = croppedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Pallet().background_R,
      appBar: AppBar(
          leading: IconButton(
            icon: Widgets().backArrowIcon(Pallet().blue_R),
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>PatientHomeScreen())
              );
            },
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Pallet().background_R,
          title: Widgets().screenTitle('اختيار صورة',Pallet().blue_R)
      ),
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

                      Widgets().arabicText(
                        text: 'احرص على وضوح اسم الدواء',
                        fontSize:Spaces().bigTitleSize,
                        color: Colors.black26,
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
                  child: Widgets().arabicText(
                        text: 'اختار من الكاميرا',
                        fontSize:Spaces().bigTitleSize,
                        color: Pallet().white_R,
                      ),

                  color: Pallet().blue_R,
                  padding: EdgeInsets.all(15),
                )),
                Expanded(
                    child: FlatButton(
                  onPressed: getGallery,
                  child: Widgets().arabicText(
                        text: 'اختار من المعرض',
                        fontSize:Spaces().bigTitleSize,
                        color: Pallet().white_R,
                      ),
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
                    String result= await ScanPrescription().postPrescription(_image);
                    // String result= await ScanPrescription().postPrescription(FirebaseAuth.instance.currentUser.uid, _image);
                    finalResult= result;
                    if(finalResult!='AI Server is Off'){
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => AIResultScreen(result: finalResult)));
                    }else{
                      setState(() {
                        progress= Widgets().arabicText(
                          text: 'السيرفر غير متاح الآن',
                          fontSize:Spaces().bigTitleSize,
                          color: Pallet().white_R,
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
