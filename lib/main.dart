import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tutor_bin_assignment/routes.dart';
import 'package:tutor_bin_assignment/screen/menu_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
          title: 'Tutor Bin Assignment',
          onGenerateRoute: generateRoutes,
          //This is first screen that shows
          home: MenuScreen(),
        );
      }
    );
  }
}
