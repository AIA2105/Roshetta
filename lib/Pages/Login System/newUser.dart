import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Constants/Spaces.dart';
import 'package:roshetta/Widgets/InputField_R.dart';
import 'package:roshetta/Widgets/LoginButton.dart';
import 'package:roshetta/Widgets/Widgets.dart';

class newUser extends StatefulWidget {
  const newUser({Key key}) : super(key: key);

  @override
  _newUserState createState() => _newUserState();
}

class _newUserState extends State<newUser> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
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
              text: 'مستخدم جديد',
              fontSize: Spaces().bigTitleSize,
              color: Pallet().blue_R)),
      body: CustomScrollView(
        reverse: true,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Image.asset(
                        'images/find.png',
                        height: 200,
                        width: 300,
                      ),
                    ),
                    InputField_R(
                      title: Widgets().arabicText(
                          text: 'البريد الالكتروني',
                          fontSize: Spaces().smallSize,
                          color: Pallet().blue_R),
                      icon: Widgets().inputFieldPrefix(Icons.person),
                      textEditingController: _emailcontroller,
                      textInputType: TextInputType.emailAddress,
                      secure: false,
                    ),

                    InputField_R(
                      title: Widgets().arabicText(
                          text: 'كلمة السر',
                          fontSize: Spaces().smallSize,
                          color: Pallet().blue_R),
                      icon: Widgets().inputFieldPrefix(Icons.lock),
                      textEditingController: _passwordcontroller,
                      textInputType: TextInputType.visiblePassword,
                      secure: true,
                    ), //password

                    Expanded(child: SizedBox(height: 20,)),

                    Padding(
                      padding: const EdgeInsets.only(left: 5,right: 5,bottom: 50),
                      child: ButtonTheme(
                        minWidth: double.maxFinite,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          color: Color(0xFF33CFE8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'متابعة',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'arabic',
                                  fontSize: 20),
                            ),
                          ),
                          onPressed: () async {LoginButton().newUser(context,_emailcontroller.text,_passwordcontroller.text);},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]
      ),
    );
  }
}
