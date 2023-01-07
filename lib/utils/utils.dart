
import 'package:flutter/material.dart';
class Utils{

  static double? deviceHeight;
  static double? deviceWidth;

  static Widget loadingView(){
    return Center(
      child: Theme(

        data: ThemeData(
        ),child: const CircularProgressIndicator(
        color: Colors.black,
      ),
      ),
    );
  }
}