//app主体
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var width = ui.window.physicalSize.width;
  var height = ui.window.physicalSize.height;
  var top = ui.window.padding.top;
  var devicePixelRatio = ui.window.devicePixelRatio;
  double fabwidth = 48;
  double fabheight = 48;

  double fabbottom = 32;
  double fabright = 32;

  double addsize = 32;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //标题栏
                Container(
                  margin: EdgeInsets.only(left: 32, top: 32, bottom: 16),
                  child: Text(
                    '热点集',
                    style: TextStyle(
                      color: Color(0xff1E1F2D),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 56,
                  width: width / devicePixelRatio,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      buildTopTab('百度', 1.0),
                      buildTopTab('抖音', 0.2),
                      buildTopTab('网易云音乐', 0.2),
                      buildTopTab('今日头条', 0.2),
                      buildTopTab('QQ看点', 0.2),
                      buildTopTab('微博', 0.2),
                    ],
                  ),
                ),
                Container(
                  height: height / devicePixelRatio -
                      56 -
                      16 -
                      32 -
                      32 -
                      top / devicePixelRatio,
                  width: width / devicePixelRatio,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      buildListItem(),
                      buildListItem(),
                      buildListItem(),
                      buildListItem(),
                      buildListItem(),
                      buildListItem(),
                      buildListItem(),
                    ],
                  ),
                )
              ],
            ),
          ),
          //小球操作按钮
          Positioned(
            bottom: fabbottom,
            right: fabright,
            child: GestureDetector(
              child: Container(
                width: fabwidth,
                height: fabheight,
                decoration: BoxDecoration(
                  color: Color(0xff1E1F2D),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(0, 24),
                        blurRadius: 12,
                        spreadRadius: -6)
                  ],
                ),
                child: Icon(
                  Icons.add,
                  size: addsize,
                  color: Colors.white,
                ),
              ),
              onTapDown: (TapDownDetails td) {
                setState(() {
                  fabwidth = 40;
                  fabheight = 40;
                  fabbottom = 36;
                  fabright = 36;
                  addsize = 24;
                });
              },
              onTapUp: (TapUpDetails tu) {
                setState(() {
                  fabwidth = 48;
                  fabheight = 48;
                  fabbottom = 32;
                  fabright = 32;
                  addsize = 32;
                });
              },
            ),
          )
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
    );
  }
}

//列表项
Container buildListItem() => Container(
      width: double.infinity,
      height: 112,
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0x101E1F2D),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 16,top: 16),
              child: Text(
          '标题',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

//顶部选项卡
GestureDetector buildTopTab(text, opacity) => GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.only(left: 32, right: 32),
        decoration: BoxDecoration(
          color: Color(0x101E1F2D),
          borderRadius: BorderRadius.circular(56),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Color.fromRGBO(30, 31, 45, opacity),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );

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
