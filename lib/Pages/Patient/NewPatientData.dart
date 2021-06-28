import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Constants/Spaces.dart';
import 'package:roshetta/Pages/Login%20System/LoginScreen.dart';
import 'package:roshetta/Pages/Patient/PatientHomeScreen.dart';
import 'package:roshetta/Widgets/InputField_R.dart';
import 'package:roshetta/Widgets/Widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'PatientDatabase.dart';

class NewPatientData extends StatefulWidget {
  const NewPatientData({Key key}) : super(key: key);
  @override
  _NewPatientDataState createState() => _NewPatientDataState();
}

class _NewPatientDataState extends State<NewPatientData> {
  TextEditingController _firstNamecontroller = TextEditingController();
  TextEditingController _lastNamecontroller = TextEditingController();
  TextEditingController _addresscontroller = TextEditingController();
  TextEditingController _phonecontroller = TextEditingController();
  String _birthday, _gender, _state, _blood;
  TextEditingController _heightcontroller = TextEditingController();
  TextEditingController _weighthcontroller = TextEditingController();
  List _bloods = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-', 'غير محدد'];
  List _genders = ['ذكر', 'أنثى'];
  List _states = ['أعزب', 'متزوج'];
  File _image;
  final picker = ImagePicker();
  String _profileImageUrl;

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

  Future uploadImage() async {
    String filename = FirebaseAuth.instance.currentUser.uid;
    Reference storageReference =
    FirebaseStorage.instance.ref().child("Profile Photos/$filename");
    final UploadTask uploadTask = storageReference.putFile(_image);
    final TaskSnapshot downloadUrl = (await uploadTask);
    _profileImageUrl = await downloadUrl.ref.getDownloadURL();
    print('$_image uploaded!');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet().background_R,
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Pallet().blue_R,
              size: Spaces().backButton,
            ),
            onPressed: () async {
              var delData = await FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .delete();
              var delAuth = await FirebaseAuth.instance.currentUser.delete();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
              print('Auth & data deleted');
            },
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Pallet().background_R,
          title: Widgets().arabicText(
              text: 'بيانات المريض',
              fontSize: Spaces().bigTitleSize,
              color: Pallet().blue_R)),
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
                            Stack(children: [
                              _image != null
                                  ? Padding(
                                      padding: const EdgeInsets.only(bottom: 20),
                                      child: CircleAvatar(
                                        radius: 75,
                                        backgroundColor: Pallet().blue_R,
                                        child: CircleAvatar(
                                            radius: 70,
                                            backgroundColor: Pallet().white_R,
                                            child: ClipOval(
                                                child: Image.file(
                                              _image,
                                              height: 150,
                                              width: 300,
                                            ))),
                                      ),
                                    )
                                  : Image.asset(
                                      'images/newPatient.png',
                                      height: 180,
                                      width: 300,
                                    ),
                              Positioned.fill(
                                  bottom: 8,
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Stack(
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          size: 30,
                                          color: Pallet().white_R,
                                        ),
                                        Icon(
                                          Icons.add_circle,
                                          size: 30,
                                          color: Pallet().red_R,
                                        ),
                                      ],
                                    )
                                  )),
                            ]),

                            Text('الصورة الشخصية', style: TextStyle(
                                color:Pallet().red_R,
                                fontFamily: 'arabic',
                                fontSize: 20)),

                          ],
                        )),
                    onTap: () {
                      pickImage();
                    },
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Pallet().white_R, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 10,
                    color: Pallet().white_R.withOpacity(0.8),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 30, top: 30),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: InputField_R(
                                      textAlign: TextAlign.right,
                                      title: Widgets().arabicText(
                                          text: 'الإسم الأخير',
                                          fontSize: Spaces().smallSize,
                                          color: Pallet().blue_R),
                                      icon: Widgets()
                                          .inputFieldPrefix(Icons.person),
                                      textEditingController:
                                          _lastNamecontroller,
                                      textInputType: TextInputType.name,
                                      secure: false),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: InputField_R(
                                      textAlign: TextAlign.right,
                                      title: Widgets().arabicText(
                                          text: 'الإسم الأول',
                                          fontSize: Spaces().smallSize,
                                          color: Pallet().blue_R),
                                      icon: Widgets()
                                          .inputFieldPrefix(Icons.person),
                                      textEditingController:
                                          _firstNamecontroller,
                                      textInputType: TextInputType.name,
                                      secure: false),
                                ),
                              ),
                            ],
                          ),
                          InputField_R(
                              textAlign: TextAlign.right,
                              title: Widgets().arabicText(
                                  text: 'العنوان',
                                  fontSize: Spaces().smallSize,
                                  color: Pallet().blue_R),
                              icon: Widgets()
                                  .inputFieldPrefix(Icons.location_on_rounded),
                              textEditingController: _addresscontroller,
                              textInputType: TextInputType.streetAddress,
                              secure: false),
                          InputField_R(
                              title: Widgets().arabicText(
                                  text: 'رقم الهاتف',
                                  fontSize: Spaces().smallSize,
                                  color: Pallet().blue_R),
                              length: 11,
                              icon: Widgets()
                                  .inputFieldPrefix(Icons.phone_iphone),
                              textEditingController: _phonecontroller,
                              textInputType: TextInputType.phone,
                              secure: false),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: InputField_R(
                                    title: Widgets().arabicText(
                                        text: 'الوزن',
                                        fontSize: Spaces().smallSize,
                                        color: Pallet().blue_R),
                                    textAlign: TextAlign.center,
                                    textEditingController: _weighthcontroller,
                                    textInputType: TextInputType.number,
                                    secure: false,
                                    length: 3,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: InputField_R(
                                    title: Widgets().arabicText(
                                        text: 'الطول',
                                        fontSize: Spaces().smallSize,
                                        color: Pallet().blue_R),
                                    textAlign: TextAlign.center,
                                    textEditingController: _heightcontroller,
                                    textInputType: TextInputType.number,
                                    secure: false,
                                    length: 3,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 8, bottom: 8),
                                    child: Widgets().datePicker(context,
                                        (DateTime value) {
                                      _birthday =
                                          '${value.year}-${value.month}-${value.day}';
                                      print(_birthday);
                                    })),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Widgets().dropDownButton(
                                      'ف. الدم', _blood, _bloods, (val) {
                                    setState(
                                      () {
                                        _blood = val;
                                      },
                                    );
                                  }),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Widgets().dropDownButton(
                                      'النوع', _gender, _genders, (val) {
                                    setState(
                                      () {
                                        _gender = val;
                                      },
                                    );
                                  }),
                                ),
                              ),
                              Expanded(
                                child: Widgets().dropDownButton(
                                    'الحالة', _state, _states, (val) {
                                  setState(
                                    () {
                                      _state = val;
                                    },
                                  );
                                }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: SizedBox(
                    height: 50,
                  )),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5, right: 5, bottom: 50),
                    child: ButtonTheme(
                      minWidth: double.maxFinite,
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          color: Color(0xFF33CFE8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'تسجيل',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'arabic',
                                  fontSize: 20),
                            ),
                          ),
                          onPressed: () async {
                            if (_firstNamecontroller.text.isNotEmpty &&
                                _lastNamecontroller.text.isNotEmpty &&
                                _addresscontroller.text.isNotEmpty &&
                                _phonecontroller.text.isNotEmpty &&
                                _birthday.isNotEmpty &&
                                _heightcontroller.text.isNotEmpty &&
                                _weighthcontroller.text.isNotEmpty) {

                              await uploadImage().then((value){
                                ////////////////////////////////////////////////////////
                                PatientDatabase().post(
                                    FirebaseAuth.instance.currentUser.email,
                                    _addresscontroller.text,
                                    _blood != null ? _blood : _bloods[0],
                                    _birthday,
                                    _firstNamecontroller.text,
                                    _lastNamecontroller.text,
                                    _gender != null ? _gender : _genders[0],
                                    _heightcontroller.text,
                                    FirebaseAuth.instance.currentUser.uid,
                                    _phonecontroller.text,
                                    _profileImageUrl != null ? _profileImageUrl : 'null',
                                    _state != null ? _state : _states[0],
                                    _weighthcontroller.text);
                                ////////////////////////////////////////////////////////

                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(FirebaseAuth.instance.currentUser.uid)
                                    .set({
                                  'id': 1,
                                  'email':
                                  FirebaseAuth.instance.currentUser.email,
                                  'First name': _firstNamecontroller.text,
                                  'Last name': _lastNamecontroller.text,
                                  'Address': _addresscontroller.text,
                                  'Phone': _phonecontroller.text,
                                  'Birthday': _birthday,
                                  'Height': _heightcontroller.text,
                                  'Weight': _weighthcontroller.text,
                                  'State': _state != null ? _state : _states[0],
                                  'Gender':
                                  _gender != null ? _gender : _genders[0],
                                  'Blood': _blood != null ? _blood : _bloods[0],
                                  'Profile Image URL': _profileImageUrl != null
                                      ? _profileImageUrl
                                      : 'null'
                                });
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PatientHomeScreen()),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                    Widgets().snakbar(
                                        text: 'تم انشاء الحساب بنجاح',
                                        background: Pallet().green,
                                        duration: 2));
                              });

                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  Widgets().snakbar(
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
