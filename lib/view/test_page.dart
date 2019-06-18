import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // Container(
              //   height: window.padding.top / window.devicePixelRatio,
              //   color: Colors.red,
              // ),
              Expanded(
                child: Container(
                  color: Colors.greenAccent,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 24,
            right: 24,
            child: GestureDetector(
              child: ClipOval(
                child: Container(
                  width: 48,
                  height: 48,
                  color: Colors.white,
                  child: Icon(Icons.arrow_back),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
