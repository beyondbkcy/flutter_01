import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  double _fabwidth = 72;
  double _fabheight = 56;
  double _fabbottom = 56;
  double _fabright = 0;
  double _addsize = 32;

  //系统属性
  Window window;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    setState(() {
      window = WidgetsBinding.instance.window;
    });
  }

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
                      color: Color(0xff242433),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 56,
                  width: window.physicalSize.width / window.devicePixelRatio,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      buildTopTab('百度', 1.0),
                      buildTopTab('抖音', 0.2),
                      buildTopTab('网易云音乐', 0.2),
                      buildTopTab('今日头条', 0.2),
                      buildTopTab('QQ看点', 0.2),
                    ],
                  ),
                ),
                Container(
                  height: window.physicalSize.height / window.devicePixelRatio -
                      56 -
                      16 -
                      32 -
                      32 -
                      window.padding.top / window.devicePixelRatio,
                  width: window.physicalSize.width / window.devicePixelRatio,
                  child: ListView(
                    // physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      buildListItem('1'),
                      buildListItem('2'),
                      buildListItem('3'),
                      buildListItem('4'),
                      buildListItem('5'),
                      buildListItem('6'),
                      buildListItem('7'),
                      buildListItem('8'),
                      buildListItem('9'),
                      buildListItem('10'),
                      buildListItem('11'),
                      buildListItem('12'),
                      buildListItem('13'),
                      buildListItem('14'),
                      buildListItem('15'),
                      buildListItem('16'),
                      buildListItem('17'),
                      buildListItem('18'),
                      buildListItem('19'),
                      buildListItem('20'),
                    ],
                  ),
                )
              ],
            ),
          ),
          //小球操作按钮
          buildPositioned()
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
          //           color: Color(0xff242433),
          //           fontSize: 16,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ),
          //     Container(
          //       margin: EdgeInsets.only(right: 24, top: 24),
          //       child: Icon(
          //         Icons.delete,
          //         color: Color(0xff242433),
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

  //底部操作按钮
  Positioned buildPositioned() {
    return Positioned(
      bottom: _fabbottom,
      right: _fabright,
      child: GestureDetector(
        child: Container(
          width: _fabwidth,
          height: _fabheight,
          decoration: BoxDecoration(
            color: Color(0xff242433),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(56),
              bottomLeft: Radius.circular(56),
            ),
          ),
          child: Icon(
            Icons.add,
            size: _addsize,
            color: Colors.white,
          ),
        ),
        onTapDown: (TapDownDetails td) {
          setState(() {
            _fabwidth = 80;
          });
        },
        onTapUp: (TapUpDetails tu) {
          setState(() {
            _fabwidth = 72;
          });
        },
        onVerticalDragUpdate: (DragUpdateDetails dud) {
          setState(() {
            _fabright = (window.physicalSize.width / window.devicePixelRatio -
                    dud.globalPosition.dx -
                    36) /
                5;
          });
          print((window.physicalSize.width / window.devicePixelRatio -
                      dud.globalPosition.dx)
                  .toString() +
              "======================");
        },
      ),
    );
  }

  //列表项
  Container buildListItem(text) {
    return Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Color(0xff242433).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  '华为在美提起诉讼',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Text(
              '7922698',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black.withOpacity(0.2),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ));
  }
}

//顶部选项卡
GestureDetector buildTopTab(text, opacity) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.only(left: 32, right: 32),
      decoration: BoxDecoration(
        color: Color(0xff242433).withOpacity(0.05),
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
        color: Color(0x10242433),
        borderRadius: BorderRadius.circular(100),
      ),
      padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
      child: Text(
        str,
        style: TextStyle(
          color: Color(0xff242433),
        ),
      ),
    );

//历史搜索小部件
Container buildContainer2(str) => Container(
      decoration: BoxDecoration(
        color: Color(0x10242433),
        borderRadius: BorderRadius.circular(100),
      ),
      padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
      child: Text(
        str,
        style: TextStyle(
          color: Color(0xff242433),
        ),
      ),
    );
