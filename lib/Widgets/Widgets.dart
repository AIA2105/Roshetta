import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Constants/Spaces.dart';

class Widgets{

  Widget arabicText({String text, Color color, double fontSize, TextDirection textDirection}){
    return Text(
      text,
      textDirection: textDirection!=null?textDirection:TextDirection.rtl,
      style: TextStyle(
          color: color,
          fontFamily: 'arabic',
          fontSize: fontSize),
    );
  }
  Widget loginScreenTitle(){
    return Column(
      children: [
        SizedBox(height: Spaces().sizedBoxHeight),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Widgets().arabicText(
                text: 'روشتة !',
                color: Pallet().red_R,
                fontSize: Spaces().bigTitleSize
            ),
            Widgets().arabicText(
                text: 'مرحبا بكم في ',
                color: Pallet().white_R,
                fontSize: Spaces().bigTitleSize
            ),
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
  Widget inputFieldPrefix(icon){
    return Icon(
      icon,
      color: Color(0xFF33CFE8),
      size: 20,
    );
  }

  Widget snakbar({String text, Color background, int duration}){
    return SnackBar(
      content: Text(
        text,
        textDirection: TextDirection.rtl,
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'arabic',
            fontSize: Spaces().smallestSize),
      ),
      backgroundColor: background,
      duration: Duration(seconds: duration),
    );
  }

  Widget datePicker(BuildContext context, Function function){
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(right: 15),
          width: double.maxFinite,
          child: Widgets().arabicText(
              fontSize: 18,
              color: Pallet().blue_R,
              text: 'تاريخ الميلاد'),
        ),
        Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Pallet().blue_R,
              onPrimary: Pallet().white_R,
            ),
            buttonTheme: ButtonThemeData(
              colorScheme: Theme.of(context)
                  .colorScheme
                  .copyWith(primary: Colors.black),
            ),
          ),
          child: DateTimeFormField(
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
            dateTextStyle: TextStyle(fontSize: Spaces().smallSize),
            decoration: InputDecoration(
                contentPadding:
                const EdgeInsets.symmetric(vertical: 12),
                fillColor: Pallet().white_R,
                filled: true,
                hintText: '',
                border: new OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(Spaces().circularBorder),
                ),
                prefixIcon: Icon(
                  Icons.date_range,
                  color: Pallet().blue_R,
                )),
            mode: DateTimeFieldPickerMode.date,
            autovalidateMode: AutovalidateMode.always,
            validator: (e) => (e?.day ?? 0) == 1
                ? 'Please not the first day'
                : null,
            onDateSelected: function,
          ),
        ),
      ],
    );
  }

  Widget dropDownButton(String title, String hint, List values, Function function){
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(right: 15),
          width: double.maxFinite,
          child: Widgets().arabicText(
              fontSize: 18,
              color: Pallet().blue_R,
              text: title),
        ),

        DropdownButtonFormField(
          decoration: InputDecoration(
            counterText: '',
            contentPadding: const EdgeInsets.only(bottom: 8,top: 8,right: 10,left: 10),
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
          hint: hint == null ?Center(
            child: Widgets().arabicText(
                text: values[0],
                fontSize: Spaces().smallSize,
                color: Pallet().blue_R),
          ):Center(
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

}