import 'dart:ui';
import 'package:flutter/material.dart';
import 'baidu_model.dart';
import 'package:http/http.dart' as http;
import 'package:gbk2utf8/gbk2utf8.dart';
import 'splash.dart';
import 'package:toast/toast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  //百度热搜数据集
  List<Baidu> _baidutopdata = [];

  //系统属性
  Window window;

  @override
  void initState() {
    super.initState();
    getBaiduTopData();
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

  //获取百度热搜数据
  getBaiduTopData() async {
    _baidutopdata.clear();
    List index = List();
    List title = List();
    List<bool> tag1 = List();
    List<int> tag2 = List();

    http.Response response = await http.get('http://top.baidu.com/buzz?b=1');
    String body = gbk.decode(response.bodyBytes);

    //正则取标题
    Iterable<Match> mtitle =
        RegExp('<a class="list-title" target="_blank" href=".*?>(.*?)</a>')
            .allMatches(body);
    for (Match m in mtitle) {
      title.add(m.group(1));
    }
    //正则取搜索指数
    Iterable<Match> mindex =
        RegExp('<span class="icon-.*?">(.*?)</span>').allMatches(body);
    for (Match m in mindex) {
      index.add(m.group(1));
    }
    //正则判断是否为新数据
    String tag1body = body.replaceAll(RegExp('\\s|\n'), '');
    Iterable<Match> mtag1 = RegExp(
            '<aclass="list-title"target="_blank"href=".*?>.*?</a>(.*?)<ahref')
        .allMatches(tag1body);
    for (Match m in mtag1) {
      tag1.add(m.group(1).isEmpty ? false : true);
    }
    //正则判断搜索指数上升和下降
    Iterable<Match> mtag2 =
        RegExp('<span class="icon-(.*?)">').allMatches(body);
    for (Match m in mtag2) {
      tag2.add(m.group(1) == 'rise' ? 1 : 2);
    }
    setState(() {
      for (var i = 0; i < index.length; i++) {
        _baidutopdata.add(Baidu(index[i], title[i], tag1[i], tag2[i]));
      }
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
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: _baidutopdata.length,
                    itemBuilder: (BuildContext bc, int i) {
                      return buildListItem(
                        (1 + i).toString(),
                        _baidutopdata[i].title,
                        _baidutopdata[i].index,
                        _baidutopdata[i].tag1,
                        _baidutopdata[i].tag2,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          //小球操作按钮
          buildPositioned(),
        ],
      ),
    );
  }

  //列表项
  Container buildListItem(id, title, index, tag1, tag2) {
    return Container(
      width: window.physicalSize.width,
      margin: EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 12),
      child: Row(
        children: <Widget>[
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: id == '1'
                  ? Colors.redAccent.withOpacity(0.25)
                  : id == '2'
                      ? Colors.orangeAccent.withOpacity(0.25)
                      : id == '3'
                          ? Colors.blueAccent.withOpacity(0.25)
                          : Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Text(
                id,
                style: TextStyle(
                    fontSize: 16,
                    color: id == '1'
                        ? Colors.redAccent
                        : id == '2'
                            ? Colors.orangeAccent
                            : id == '3'
                                ? Colors.blueAccent
                                : Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(width: 24),
          Splash(
            child: Container(
              width: (window.physicalSize.width / window.devicePixelRatio) - 96,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xff242433).withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('搜索指数 : ' + index,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.25))),
                      Row(
                        children: <Widget>[
                          Text('新',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: tag1 == true
                                      ? Colors.red.withOpacity(1)
                                      : Colors.red.withOpacity(0))),
                          SizedBox(width: 16),
                          Text(tag2 == 1 ? '上升↑' : '下降↓',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: tag2 == 1 ? Colors.red : Colors.blue))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
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

  //底部操作按钮
  Positioned buildPositioned() {
    return Positioned(
      bottom: 28,
      right: 28,
      child: GestureDetector(
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
              color: Color(0xff242433),
              borderRadius: BorderRadius.circular(56),
              boxShadow: [
                BoxShadow(
                  color: Color(0xff242433).withOpacity(0.5),
                  blurRadius: 30,
                  offset: Offset(0, 30),
                )
              ]),
          child: Icon(
            Icons.refresh,
            size: 28,
            color: Colors.white,
          ),
        ),
        onTap: () {
          getBaiduTopData();
          Toast.show('刷新成功！', context, backgroundColor: Colors.black);
        },
      ),
    );
  }
}
