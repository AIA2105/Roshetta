import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Constants/Spaces.dart';
import 'package:roshetta/Constants/Strings.dart';
import 'package:roshetta/Pages/Login%20System/LoginScreen.dart';
import 'package:roshetta/Widgets/InputField_R.dart';
import 'package:roshetta/Widgets/Widgets.dart';
import 'DoctorDatabase.dart';
import 'DoctorHomeScreen.dart';

class NewDoctorData extends StatefulWidget {
  const NewDoctorData({Key key}) : super(key: key);

  @override
  _NewDoctorDataState createState() => _NewDoctorDataState();
}

class _NewDoctorDataState extends State<NewDoctorData> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  String _birthday, _gender, _master;
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
  TextEditingController _hospitalController = TextEditingController();
  List _genders = ['ذكر', 'أنثى'];
  File _image;
  final picker = ImagePicker();
  Widget signUp=Widgets().arabicText(
    text: 'تسجيل',
    fontSize: Spaces().mediumSize,
    color: Pallet().white_R,
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
            onPressed: () async{
              var delData = await FirebaseFirestore.instance.collection(Strings().fireStoreTableName).doc(FirebaseAuth.instance.currentUser.uid).delete();
              var delAuth = await FirebaseAuth.instance.currentUser.delete();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
              print('Auth & data deleted');
            }
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Pallet().background_R,
          title: Widgets().screenTitle('بيانات الطبيب',Pallet().blue_R)
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
                                'images/newDoctor.png',
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

                            Widgets().arabicText(
                              text: 'الصورة الشخصية',
                              fontSize: Spaces().mediumSize,
                              color: Pallet().red_R,
                            ),

                          ],
                        )),
                    onTap: () {
                      pickImage();
                    },
                  ),
                  Card(
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
                                          _lastNameController,
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
                                          _firstNameController,
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
                              textEditingController: _addressController,
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
                              textEditingController: _phoneController,
                              textInputType: TextInputType.phone,
                              secure: false),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 8, bottom: 8),
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
                                flex: 2,
                                child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 8, bottom: 8),
                                    child: Widgets().datePicker('','تاريخ الميلاد',context,
                                        (DateTime value) {
                                      _birthday =
                                          '${value.year}-${value.month}-${value.day}';
                                      print(_birthday);
                                    })),
                              ),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Widgets().dropDownButton(
                                'التخصص', _master, _masters, (val) {
                              setState(
                                    () {
                                  _master = val;
                                },
                              );
                            }),
                          ),
                          InputField_R(
                            title: Widgets().arabicText(
                                text: 'المستشفى/ العيادة',
                                fontSize: Spaces().smallSize,
                                color: Pallet().blue_R),
                            textAlign: TextAlign.right,
                            textEditingController: _hospitalController,
                            textInputType: TextInputType.text,
                            secure: false,
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
                            child: signUp,
                          ),
                          onPressed: () async {

                            if (_firstNameController.text.isNotEmpty &&
                                _lastNameController.text.isNotEmpty &&
                                _addressController.text.isNotEmpty &&
                                _phoneController.text.isNotEmpty &&
                                _birthday.isNotEmpty &&
                                _master.isNotEmpty &&
                                _hospitalController.text.isNotEmpty) {

                              setState(() {
                                signUp= CircularProgressIndicator(color: Pallet().white_R,);
                              });
                                ////////////////////////////////////////////////////////
                                var res= await DoctorDatabase().post(
                                  FirebaseAuth.instance.currentUser.uid,
                                  FirebaseAuth.instance.currentUser.email,
                                  _addressController.text,
                                  _firstNameController.text,
                                  _lastNameController.text,
                                  _birthday,
                                  _master != null ? _master : _masters[0],
                                  _hospitalController.text,
                                  _gender != null ? _gender : _genders[0],
                                  _phoneController.text,
                                  _image != null ? _image : null,
                                );
                                ////////////////////////////////////////////////////////

                              if(res=='false'){
                                setState(() {
                                  signUp= Widgets().arabicText(
                                    text: 'تسجيل',
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
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DoctorHomeScreen()),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                    Widgets().snakBar(
                                        text: 'تم انشاء الحساب بنجاح',
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
