import 'package:flutter/material.dart';
import 'view/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // primaryColor: Color(0xFFF8F8FA),
        // accentColor: Color(0xff242433),
        primaryColor: Color(0xff242433),
        accentColor: Color(0xfffafa90),
      ),
      debugShowCheckedModeBanner: true,
      title: '热搜集',
      home: HomePage(),
    );
  }
}
