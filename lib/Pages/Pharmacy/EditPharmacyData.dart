import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roshetta/Constants/Links.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Constants/Spaces.dart';
import 'package:roshetta/Constants/Strings.dart';
import 'package:roshetta/Pages/Login%20System/LoginScreen.dart';
import 'package:roshetta/Pages/Pharmacy/Pharmacy.dart';
import 'package:roshetta/Widgets/DeleteAccount.dart';
import 'package:roshetta/Widgets/InputField_R.dart';
import 'package:roshetta/Widgets/Widgets.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'PharmacyDatabase.dart';
import 'PharmacyHomeScreen.dart';

class EditPharmacyData extends StatefulWidget {
  Pharmacy pharmacy;
  EditPharmacyData(this.pharmacy);

  @override
  _EditPharmacyDataState createState() => _EditPharmacyDataState();
}

class _EditPharmacyDataState extends State<EditPharmacyData> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  String _hours, _delivery;
  TextEditingController _pharmacyNameController = TextEditingController();
  List _yesOrNo = ['نعم', 'لا'];
  File _image;
  final picker = ImagePicker();
  Widget editData= Widgets().arabicText(
    text: 'تعديل',
    fontSize: Spaces().mediumSize,
    color: Pallet().white_R,
  );

  Future<void> _download() async {
    final _url= '${Links().profileImage}/${FirebaseAuth.instance.currentUser.uid}/${widget.pharmacy.profileImage}';
    final response = await http.get(Uri.parse(_url));

    // Get the image name
    final imageName = path.basename(_url);
    // Get the document directory path
    final appDir = await pathProvider.getApplicationDocumentsDirectory();

    // This is the saved image path
    // You can use it to display the saved image later.
    final localPath = path.join(appDir.path, imageName);

    // Downloading
    final imageFile = File(localPath);
    await imageFile.writeAsBytes(response.bodyBytes);

    setState(() {
      _image = imageFile;
      print('Image from internet');
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _download();
      _firstNameController.text=widget.pharmacy.firstName;
      _lastNameController.text=widget.pharmacy.lastName;
      _addressController.text=widget.pharmacy.address;
      _phoneController.text=widget.pharmacy.phoneNumber;
      _pharmacyNameController.text=widget.pharmacy.pharmacyName;
      _hours=widget.pharmacy.workHours;
      _delivery=widget.pharmacy.delivery;
    });
  }
  
  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        print('Image from gallery');
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
                Navigator.pop(context);
              }
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Pallet().background_R,
          title: Widgets().screenTitle('تعديل بيانات الصيدلي',Pallet().blue_R)
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
                                            ?Image.file(
                                          _image,
                                          height: 150,
                                          width: 300,
                                        ):Image.network(
                                          '${Links().profileImage}/${FirebaseAuth.instance.currentUser.uid}/${widget.pharmacy.profileImage}',
                                          height: 130,
                                          width: 300,
                                          loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return Center(
                                              child: CircularProgressIndicator(color: Pallet().blue_R,),
                                            );
                                          },
                                        ),
                                      )),
                                ),
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
                        )
                    ),
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
                            title: Widgets().arabicText(
                                text: 'اسم الصيدلية',
                                fontSize: Spaces().smallSize,
                                color: Pallet().blue_R),
                            textAlign: TextAlign.right,
                            textEditingController: _pharmacyNameController,
                            textInputType: TextInputType.text,
                            secure: false,
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
                                      'خدمة توصيل', _delivery, _yesOrNo, (val) {
                                    setState(
                                          () {
                                        _delivery = val;
                                      },
                                    );
                                  }),
                                ),
                              ),

                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 8, bottom: 8),
                                  child: Widgets().dropDownButton(
                                      'نعمل 24/7', _hours, _yesOrNo, (val) {
                                    setState(
                                          () {
                                        _hours = val;
                                      },
                                    );
                                  }),
                                ),
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
                    child: Row(
                      children: [
                        DeleteAccount(),
                        SizedBox(width: 8),
                        Expanded(
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0)),
                              color: Pallet().blue_R,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: editData,
                              ),
                              onPressed: () async {
                                ////////////////////////////////////////////////////////
                                if (_firstNameController.text.isNotEmpty &&
                                    _lastNameController.text.isNotEmpty &&
                                    _addressController.text.isNotEmpty &&
                                    _phoneController.text.isNotEmpty &&
                                    _pharmacyNameController.text.isNotEmpty) {

                                  setState(() {
                                    editData= CircularProgressIndicator(color: Pallet().white_R,);
                                  });
                                  ////////////////////////////////////////////////////////
                                  var res= await PharmacyDatabase().update(
                                    FirebaseAuth.instance.currentUser.uid,
                                    FirebaseAuth.instance.currentUser.email,
                                    _addressController.text,
                                    _pharmacyNameController.text,
                                    _firstNameController.text,
                                    _lastNameController.text,
                                    _delivery,
                                    _hours,
                                    _phoneController.text,
                                    _image,
                                  );
                                  ////////////////////////////////////////////////////////
                                  print(res);

                                  if(res=='false'){
                                    setState(() {
                                      editData= Widgets().arabicText(
                                        text: 'تعديل',
                                        fontSize: Spaces().mediumSize,
                                        color: Pallet().white_R,
                                      );
                                    });

                                    ScaffoldMessenger.of(context).showSnackBar(
                                        Widgets().snakBar(
                                            text: 'حدثت مشكلة برجاء المحاولة لاحقاََ',
                                            background: Pallet().red_R,
                                            duration: 2));
                                    //

                                  }else{
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PharmacyHomeScreen()),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        Widgets().snakBar(
                                            text: 'تم تعديل البيانات بنجاح',
                                            background: Pallet().green,
                                            duration: 2));
                                  }
                                  //
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
                      ],
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
