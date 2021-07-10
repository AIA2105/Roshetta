import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Constants/Spaces.dart';
import 'package:roshetta/Pages/Patient/PatientHomeScreen.dart';
import 'package:roshetta/Pages/Patient/Prescription/LocalPrescriptions.dart';
import 'package:roshetta/Widgets/InputField_R.dart';
import 'package:roshetta/Widgets/Widgets.dart';

import 'PrescriptionDatabase.dart';

class AddLocalPrescription extends StatefulWidget {
  const AddLocalPrescription({Key key}) : super(key: key);
  @override
  _AddLocalPrescriptionState createState() => _AddLocalPrescriptionState();
}

class _AddLocalPrescriptionState extends State<AddLocalPrescription> {
  TextEditingController _doctorName = TextEditingController();
  String _date, _master;
  List _masters = [
    'جراحة العظام',
    'جراحة عامة',
    'أمراض قلب',
    'جراحة تجميلية',
    'أطفال',
    'باطنة',
    'أسنان',
    'نفسية',
    'عيون',
    'انف وأذن',
    'علاج طبيعي',
    'مسالك بولية',
    'نسا وتوليد',
    'جلدية',
    'ذكورة وعقم',
    'غير ذلك'];
  File _image;
  final picker = ImagePicker();
  Widget upload=Padding(
      padding: EdgeInsets.all(10),
      child: Widgets().arabicText(
        text: 'حفظ',
        fontSize: Spaces().mediumSize,
        color: Pallet().white_R,
      ) ,
  );

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet().background_R,
      appBar: AppBar(
          leading: IconButton(
            icon: Widgets().backArrowIcon(Pallet().blue_R),
            onPressed: ()  {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PatientHomeScreen()),
              );
            },
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Pallet().background_R,
          title: Widgets().screenTitle('حفظ روشتة جديدة',Pallet().blue_R)
      ),
      body: CustomScrollView(

        //reverse: true,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                //mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: CircleAvatar(
                                radius: 75,
                                backgroundColor: Pallet().blue_R,
                                child: CircleAvatar(
                                    radius: 70,
                                    backgroundColor: Pallet().white_R,
                                    child: ClipOval(
                                        child: _image != null
                                            ? Image.file(
                                          _image,
                                          height: 150,
                                          width: 300,
                                        ):
                                      Icon(Icons.image,size: 100,color: Pallet().blue_R,),
                                    )),
                              ),
                            ),

                            Widgets().arabicText(
                              text: 'صورة الروشتة',
                              fontSize: Spaces().mediumSize,
                              color: Pallet().red_R,
                            ),

                          ],
                        )),
                    onTap: () {
                      pickImage();
                    },
                  ),
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Pallet().white_R, width: 1),
                        borderRadius: BorderRadius.circular(Spaces().mediumSize),
                      ),
                      elevation: 10,
                      color: Pallet().white_R.withOpacity(0.8),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 30, top: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                                padding:
                                EdgeInsets.only(left: 8, bottom: 8),
                                child: Widgets().datePicker('','تاريخ الروشتة',context,
                                        (DateTime value) {
                                      _date =
                                      '${value.year}-${value.month}-${value.day}';
                                      print(_date);
                                    })),

                            InputField_R(
                                textAlign: TextAlign.right,
                                title: Widgets().arabicText(
                                    text: 'اسم الطبيب',
                                    fontSize: Spaces().mediumSize,
                                    color: Pallet().blue_R),
                                icon: Widgets()
                                    .inputFieldPrefix(Icons.person),
                                textEditingController: _doctorName,
                                textInputType: TextInputType.streetAddress,
                                secure: false),

                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Widgets().dropDownButton(
                                  'التخصص', _master, _masters, (val) {
                                setState(
                                      () {
                                    _master = val;
                                  },
                                );
                              }),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 5, right: 5, bottom: 50),
                    child: ButtonTheme(
                      minWidth: double.maxFinite,
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          color: Color(0xFF33CFE8),
                          child: upload,
                          onPressed: () async {
                            if (_image!= null &&
                                _date.isNotEmpty &&
                                _doctorName.text.isNotEmpty) {

                              setState(() {
                                upload= Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CircularProgressIndicator(color: Pallet().white_R,),
                                );
                              });
                              ////////////////////////////////////////////////////////
                              var res =await PrescriptionDatabase().postLocal(
                                  FirebaseAuth.instance.currentUser.uid,
                                  _doctorName.text,
                                  _master != null ? _master : _masters[0],
                                  _date,
                                  _image);
                              ////////////////////////////////////////////////////////

                              //print(res);

                              if(res=='false'){
                                setState(() {
                                  upload=  Widgets().arabicText(
                                    text: 'حفظ',
                                    fontSize: Spaces().mediumSize,
                                    color: Pallet().white_R,
                                  );
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                    Widgets().snakBar(
                                        text: 'حدثت مشكلة برجاء المحاولة لاحقاََ',
                                        background: Pallet().red_R,
                                        duration: 2));

                              }else{
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LocalPrescriptions()),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                    Widgets().snakBar(
                                        text: 'تم الحفظ بنجاح',
                                        background: Pallet().green,
                                        duration: 2));
                              }

                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                  Widgets().snakBar(
                                      text: 'برجاء اكمال البيانات',
                                      background: Pallet().red_R,
                                      duration: 2));
                            }
                          }
                        ////////////////////////////////////////////////////////

                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


