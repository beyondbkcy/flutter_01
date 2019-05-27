import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './view/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: '网易云音乐',
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
          backgroundColor: Color(0xFFE0E0F1),
          body: HomePage(),
        ),
      ),
    );
  }
}
