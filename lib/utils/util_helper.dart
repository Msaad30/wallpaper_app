
import 'package:flutter/material.dart';

class AppColors{
  static final primaryLightColor = Color(0xffdaeaf0);
  static final secondaryLightColor = Colors.white;
  static final mainColor = Color(0xfff364f4);
  static final searchTextColor = Color(0xffb3b5bc);
}

TextStyle mTextStyle12({
  Color mColor = Colors.black,
  mFontWeight = FontWeight.normal}){
  return TextStyle(
      fontSize : 12,
      fontWeight : mFontWeight,
      color : mColor,
      fontFamily: 'mainFont'
  );
}

TextStyle mTextStyle14({
  Color mColor = Colors.black,
  mFontWeight = FontWeight.normal}){
  return TextStyle(
      fontSize : 14,
      fontWeight : mFontWeight,
      color : mColor,
      fontFamily: 'mainFont'
  );
}

TextStyle mTextStyle16({
  Color mColor = Colors.black,
  mFontWeight = FontWeight.normal}){
  return TextStyle(
      fontSize : 16,
      fontWeight : mFontWeight,
      color : mColor,
      fontFamily: 'mainFont'
  );
}

TextStyle mTextStyle25({
  Color mColor = Colors.black,
  mFontWeight = FontWeight.normal}){
  return TextStyle(
      fontSize : 25,
      fontWeight : mFontWeight,
      color : mColor,
      fontFamily: 'mainFont'
  );
}

TextStyle mTextStyle34({
  Color mColor = Colors.black,
  mFontWeight = FontWeight.normal}){
  return TextStyle(
      fontSize : 34,
      fontWeight : mFontWeight,
      color : mColor,
      fontFamily: 'mainFont'
  );
}

void pageSnackbar({required BuildContext context,required String title}){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              CircularProgressIndicator(),
            ],
          ),
      )
  );
}

void msgSnackbar({required BuildContext context,required String title}){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
      )
  );
}
