
import 'package:flutter/material.dart';

class AppColors{
  static final primaryLightColor = Color(0xffddebf2);
  static final secondaryLightColor = Color(0xff33f3f5);
  static final mainColor = Color(0xfff364f4);
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