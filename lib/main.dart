

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weatheronics/Pages/Home.dart';
import 'package:weatheronics/Pages/Loading.dart';
import 'package:weatheronics/Pages/ChooseLocation.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(
    statusBarColor: Colors.black38,
    statusBarIconBrightness: Brightness.light,

  ));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Weatheronics",
    routes : {
      "/" : (context) => Loading(), //default route
      "/home" : (context) => Home(),
      "/loading": (context) => Loading(),
    },
  ));
}

