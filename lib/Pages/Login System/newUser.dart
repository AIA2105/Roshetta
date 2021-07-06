import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Constants/Spaces.dart';
import 'package:roshetta/Constants/Strings.dart';
import 'package:roshetta/Widgets/InputField_R.dart';
import 'package:roshetta/Widgets/AccountButtons.dart';
import 'package:roshetta/Widgets/Widgets.dart';

class newUser extends StatefulWidget {
  String email;
  newUser(this.email);

  @override
  _newUserState createState() => _newUserState();
}

class _newUserState extends State<newUser> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _passwordcontroller2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailcontroller.text=widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Pallet().background_R,
      appBar: AppBar(
          leading: IconButton(
            icon: Widgets().backArrowIcon(),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Pallet().background_R,
          title: Widgets().screenTitle('مستخدم جديد',Pallet().blue_R)
    ),
      body: CustomScrollView(reverse: true, slivers: [
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

                InputField_R(
                  title: Widgets().arabicText(
                      text: 'تأكيد كلمة السر',
                      fontSize: Spaces().smallSize,
                      color: Pallet().blue_R),
                  icon: Widgets().inputFieldPrefix(Icons.lock),
                  textEditingController: _passwordcontroller2,
                  textInputType: TextInputType.visiblePassword,
                  secure: true,
                ),

                Expanded(
                    child: SizedBox(
                  height: Spaces().mediumSize,
                )),

                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5, bottom: 50),
                  child: ButtonTheme(
                    minWidth: double.maxFinite,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      color: Color(0xFF33CFE8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Widgets().arabicText(
                            text: 'متابعة',
                            fontSize: Spaces().mediumSize,
                            color: Pallet().white_R
                        ),
                      ),
                      onPressed: () async {
                        if(_passwordcontroller.text==_passwordcontroller2.text){
                          AccountButtons().newUser(context, _emailcontroller.text,
                              _passwordcontroller.text);
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(Widgets().snakBar(
                              text: 'كلمة المرور غير متطابقة',
                              background: Pallet().red_R,
                              duration: 2
                          ));
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
