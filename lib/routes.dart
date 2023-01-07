

import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tutor_bin_assignment/constants/screen_name_constants.dart';
import 'package:tutor_bin_assignment/screen/menu_screen.dart';
import 'package:tutor_bin_assignment/screen/success_screen.dart';



Route<dynamic> generateRoutes(RouteSettings settings){

  switch(settings.name){
    case successScreen:return customPageTransition(widget: SuccessScreen(), settings: settings);
    default: return customPageTransition(settings: settings,widget: const MenuScreen());
  }

}


customPageTransition({required Widget widget,required RouteSettings settings}){
  return PageTransition(
      child: widget,
      type: PageTransitionType.rightToLeft,
      settings: settings,
      duration: const Duration(milliseconds: 300),reverseDuration: const Duration(milliseconds: 300)
  );
}