import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Constants/Spaces.dart';
import 'package:roshetta/Widgets/Widgets.dart';
import 'package:roshetta/main.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Widgets().arabicText(
            text: 'لا يوجد انترنت اضغط لإعادة المحاولة',
            color: Pallet().white_R,
            fontSize: Spaces().smallestSize),
        backgroundColor: Pallet().red_R,
        onPressed: () => main(),
        icon: Icon(Icons.refresh),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/logo.png'),
            Widgets().arabicText(
                text: 'روشتة',
                color: Pallet().red_R,
                fontSize: Spaces().bigTitleSize),
          ],
        )),
      ),
    );
  }
}
