import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Constants/Spaces.dart';
import 'package:roshetta/Widgets/InputField_R.dart';
import 'package:roshetta/Widgets/LoginButton.dart';
import 'package:roshetta/Widgets/Widgets.dart';
import 'package:roshetta/Pages/Login%20System/newUser.dart';
import 'package:flutter/rendering.dart';
import '../../AI/camera.dart';
import 'forgetPassword.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  Widget login= Widgets().arabicText(
      text: 'الدخول',
      color: Pallet().white_R,
      fontSize: Spaces().smallSize);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      //  extendBody: true,
      //backgroundColor: Pallet().background_R,
      body: Container(
        height: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: SingleChildScrollView(
          reverse: true,
          padding: EdgeInsets.all(Spaces().padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Widgets().loginScreenTitle(),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                      ), //text

                      Container(
                        padding: EdgeInsets.only(left: 8),
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgetPassword()),
                            );
                          },
                          child: Text(
                            'نسيت كلمةالسر؟',
                            style: TextStyle(
                              color: Pallet().red_R,
                              fontFamily: 'arabic',
                              fontSize: Spaces().smallestSize,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Spaces().sizedBoxHeight + 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      ScaffoldMessenger.of(context).showSnackBar(Widgets().snakbar(
                                          text: 'قريباََ',
                                          background: Pallet().green,
                                          duration: 2
                                      ));
                                    },
                                    child: Image.asset('images/facebook.png'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      ScaffoldMessenger.of(context).showSnackBar(Widgets().snakbar(
                                          text: 'قريباََ',
                                          background: Pallet().green,
                                          duration: 2
                                      ));
                                    },
                                    child: Image.asset('images/google.png'),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              Widgets().arabicText(
                                  text: 'الدخول باستخدام',
                                  color: Pallet().blue_R,
                                  fontSize: Spaces().smallestSize)
                            ],
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                ButtonTheme(
                                  minWidth: double.maxFinite,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(
                                            Spaces().circularBorder)),
                                    color: Pallet().blue_R,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: login,
                                    ),
                                    onPressed: () async {
                                      LoginButton().login(
                                          context,
                                          _emailcontroller.text,
                                          _passwordcontroller.text).then((value) {
                                        if(value){
                                          setState(() {
                                            login = CircularProgressIndicator(color: Pallet().white_R,);
                                          });
                                        }
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => newUser(_emailcontroller.text)),
                                      );
                                    },
                                    child: Text(
                                      '! مستخدم جديد',
                                      style: TextStyle(
                                        color: Pallet().red_R,
                                        fontFamily: 'arabic',
                                        fontSize: Spaces().smallSize,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
