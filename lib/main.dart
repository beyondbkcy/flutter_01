import 'dart:ui';

import 'package:flutter/material.dart';
import './utils/System.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemUtils.setStatusBarStyle(Brightness.dark);
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: '网易云音乐',
      home: Home(),
    );
  }
}

//app主体
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            //底部栏
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              height: 56,
              child: Container(
                color: Colors.white,
              ),
            ),
            //小球
            Positioned(
              bottom:32,
              right: 28,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(48),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: Offset(0, 20),
                      blurRadius: 28,
                    )
                  ]
                ),
              ),
            )
            // Container(
            //   alignment: Alignment.topLeft,
            //   margin: EdgeInsets.only(top: 24, left: 24),
            //   child: Text(
            //     '热门搜索',
            //     style: TextStyle(
            //       color: Color(0xff1E1F2D),
            //       fontSize: 32,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            // buildHotSearch(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: <Widget>[
            //     Container(
            //       alignment: Alignment.topLeft,
            //       margin: EdgeInsets.only(left: 24, top: 24),
            //       child: Text(
            //         '历史搜索',
            //         style: TextStyle(
            //           color: Color(0xff1E1F2D),
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ),
            //     Container(
            //       margin: EdgeInsets.only(right: 24, top: 24),
            //       child: Icon(
            //         Icons.delete,
            //         color: Color(0xff1E1F2D),
            //         size: 24,
            //       ),
            //     )
            //   ],
            // ),
            // buildHistoricalSearch(),
          ],
        ),
      ),
    );
  }
}

// 热门搜索
Container buildHotSearch() => Container(
      padding: EdgeInsets.only(left: 0, top: 16),
      child: Wrap(
        runSpacing: 8,
        spacing: 8,
        children: <Widget>[
          buildContainer1('孤单心事'),
          buildContainer1('青春住了谁'),
          buildContainer1('Taylor Swift'),
          buildContainer1('袁娅维远方韵律'),
          buildContainer1('复仇者联盟'),
          buildContainer1('bad guy'),
        ],
      ),
    );

// 历史搜索
Container buildHistoricalSearch() => Container(
      padding: EdgeInsets.only(left: 0, top: 16),
      child: Wrap(
        runSpacing: 8,
        spacing: 8,
        children: <Widget>[
          buildContainer2('Beyond'),
          buildContainer2('你的酒馆对我打了烊'),
          buildContainer2('灰色轨迹'),
          buildContainer2('大碗宽面'),
          buildContainer2('大碗宽面'),
          buildContainer2('大碗宽面'),
        ],
      ),
    );

// 热门搜索小部件
Container buildContainer1(str) => Container(
      decoration: BoxDecoration(
        color: Color(0x101E1F2D),
        borderRadius: BorderRadius.circular(100),
      ),
      padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
      child: Text(
        str,
        style: TextStyle(
          color: Color(0xff1E1F2D),
        ),
      ),
    );

//历史搜索小部件
Container buildContainer2(str) => Container(
      decoration: BoxDecoration(
        color: Color(0x101E1F2D),
        borderRadius: BorderRadius.circular(100),
      ),
      padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
      child: Text(
        str,
        style: TextStyle(
          color: Color(0xff1E1F2D),
        ),
      ),
    );
