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
          statusBarIconBrightness: Brightness.dark,//状态栏主题
          statusBarColor: Colors.transparent,//状态栏背景颜色
        ),
        child: Scaffold(
          backgroundColor: Colors.white,//背景颜色
          body: HomePage(),
        ),
      ),
    );
  }
}
