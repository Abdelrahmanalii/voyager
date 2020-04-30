import '../main.dart';
import 'package:flutter/material.dart';
import '../contactUs.dart';
import '../home.dart';
import '../utils/data.dart';

Future navigateToSubPageContact(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUs()));
}

Future navigateToSubPageHome(context) async {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Home(Data.userLang.toLowerCase())));
}

Future navigateToSubPageLogout(context) async {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => MyHomePage()));
}
