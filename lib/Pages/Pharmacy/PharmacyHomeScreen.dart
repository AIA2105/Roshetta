import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roshetta/Constants/Pallet.dart';
import '../Login System/LoginScreen.dart';

class PharmacyHomeScreen extends StatefulWidget {
  const PharmacyHomeScreen({Key key}) : super(key: key);

  @override
  _PharmacyHomeScreenState createState() => _PharmacyHomeScreenState();
}

class _PharmacyHomeScreenState extends State<PharmacyHomeScreen> {
  String name = '';
  String photoUrl;

  @override
  initState() {
    super.initState();
    getName();
  }

  void getName() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Hello ${documentSnapshot['First name']}');
        print('your photo: ${documentSnapshot['Profile Image URL']}');
        setState(() {
          name = documentSnapshot['First name'];
          photoUrl = documentSnapshot['Profile Image URL'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF33CFE8),
        title: Text(
          'الصفحة الرئيسية للصيدلي',
          textDirection: TextDirection.rtl,
          style: TextStyle(
              color: Colors.white, fontFamily: 'arabic', fontSize: 20),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: photoUrl != "null"
                  ? CircleAvatar(
                radius: 75,
                backgroundColor: Pallet().blue_R,
                child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Pallet().white_R,
                    child: ClipOval(
                        child: Image.network(
                          photoUrl,
                          height: 150,
                          width: 300,
                        ))),
              )
                  : Image.asset(
                'images/newPharmacy.png',
                height: 180,
                width: 300,
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                // 'مرحبا بك\n${FirebaseAuth.instance.currentUser.email}',
                'مرحبا بك $name',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    color: Color(0xFFC63C22),
                    fontFamily: 'arabic',
                    fontSize: 22),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  onPressed: () async {
                    var result = await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    'تسجيل الخروج',
                    style: TextStyle(
                        color: Color(0xFFC63C22),
                        fontFamily: 'arabic',
                        fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
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
                  child: Text(
                    'حذف الحساب',
                    style: TextStyle(
                        color: Color(0xFFC63C22),
                        fontFamily: 'arabic',
                        fontSize: 20),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
