import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:roshetta/Constants/Links.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Constants/Spaces.dart';
import 'package:roshetta/Constants/Strings.dart';

class Widgets {
  Widget arabicText(
      {String text,
      Color color,
      double fontSize,
      TextDirection textDirection}) {
    return Text(
      text,
      textDirection: textDirection != null ? textDirection : TextDirection.rtl,
      style: TextStyle(
          color: color,
          fontFamily: Strings().arabicFontFamily,
          fontSize: fontSize),
    );
  }

  Widget loginScreenTitle() {
    return Column(
      children: [
        SizedBox(height: Spaces().sizedBoxHeight),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Widgets().arabicText(
                text: 'روشتة !',
                color: Pallet().red_R,
                fontSize: Spaces().bigTitleSize),
            Widgets().arabicText(
                text: 'مرحبا بكم في ',
                color: Pallet().white_R,
                fontSize: Spaces().bigTitleSize),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Image.asset(
            'images/logo.png',
            height: 100,
          ),
        ), //image
        SizedBox(height: Spaces().sizedBoxHeight),
      ],
    );
  }

  Widget inputFieldPrefix(icon) {
    return Icon(
      icon,
      color: Pallet().blue_R,
      size: Spaces().mediumSize,
    );
  }

  Widget snakBar({String text, Color background, int duration}) {
    return SnackBar(
      content: Widgets().arabicText(
          text: text,
          fontSize: Spaces().smallSize,
          color: Pallet().white_R,
          textDirection: TextDirection.rtl),
      backgroundColor: background,
      duration: Duration(seconds: duration),
    );
  }

  Widget datePicker(String hint, BuildContext context, Function function) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(right: 15),
          width: double.maxFinite,
          child: Widgets().arabicText(
              fontSize: 18, color: Pallet().blue_R, text: 'تاريخ الميلاد'),
        ),
        Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Pallet().blue_R,
              onPrimary: Pallet().white_R,
            ),
            buttonTheme: ButtonThemeData(
              colorScheme:
                  Theme.of(context).colorScheme.copyWith(primary: Colors.black),
            ),
          ),
          child: DateTimeFormField(
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
            dateTextStyle: TextStyle(fontSize: Spaces().smallSize),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                fillColor: Pallet().white_R,
                filled: true,
                hintText: hint,
                border: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Spaces().circularBorder),
                ),
                prefixIcon: Icon(
                  Icons.date_range,
                  color: Pallet().blue_R,
                )),
            mode: DateTimeFieldPickerMode.date,
            autovalidateMode: AutovalidateMode.always,
            // validator: (e) => (e?.day ?? 0) == 1
            //     ? 'Please not the first day'
            //     : null,
            onDateSelected: function,
          ),
        ),
      ],
    );
  }

  Widget dropDownButton(
      String title, String hint, List values, Function function) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(right: 15),
          width: double.maxFinite,
          child: Widgets()
              .arabicText(fontSize: 18, color: Pallet().blue_R, text: title),
        ),
        DropdownButtonFormField(
          decoration: InputDecoration(
            counterText: '',
            contentPadding:
                const EdgeInsets.only(bottom: 8, top: 8, right: 10, left: 10),
            fillColor: Pallet().white_R,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Spaces().circularBorder),
              borderSide: BorderSide(width: 2, color: Pallet().blue_R),
            ),
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(Spaces().circularBorder),
            ),
          ),
          isExpanded: true,
          hint: hint == null
              ? Center(
                  child: Widgets().arabicText(
                      text: values[0],
                      fontSize: Spaces().smallSize,
                      color: Pallet().blue_R),
                )
              : Center(
                  child: Widgets().arabicText(
                      text: hint,
                      fontSize: Spaces().smallSize,
                      color: Pallet().blue_R),
                ),
          iconSize: 30.0,
          style: TextStyle(color: Pallet().blue_R),
          items: values.map(
            (val) {
              return DropdownMenuItem<String>(
                alignment: Alignment.topRight,
                value: val,
                child: Widgets().arabicText(
                    text: val,
                    fontSize: Spaces().smallSize,
                    color: Pallet().blue_R),
              );
            },
          ).toList(),
          onChanged: function,
        ),
      ],
    );
  }

  Widget profilePicture(String userID, String profileImage) {
    return Stack(
      children: [
        Padding(
            padding: const EdgeInsets.all(20),
            child: CircleAvatar(
              radius: 75,
              backgroundColor: Pallet().blue_R,
              child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Pallet().white_R,
                  child: ClipOval(
                      child: Image.network(
                    '${Links().profileImage}/$userID/$profileImage',
                    height: 130,
                    width: 300,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          color: Pallet().blue_R,
                        ),
                      );
                    },
                  ))),
            )),
        Positioned.fill(
            bottom: 20,
            left: 90,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Stack(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 30,
                      color: Pallet().red_R,
                    ),
                    Positioned.fill(
                      child: Icon(
                        Icons.edit_outlined,
                        size: 20,
                        color: Pallet().white_R,
                      ),
                    ),
                  ],
                ))),
      ],
    );
  }

  Widget backArrowIcon() {
    return Icon(
      Icons.arrow_back_ios,
      color: Pallet().blue_R,
      size: Spaces().biggest,
    );
  }

  Widget screenTitle(String title, Color color) {
    return Widgets()
        .arabicText(text: title, fontSize: Spaces().bigTitleSize, color: color);
  }
}
