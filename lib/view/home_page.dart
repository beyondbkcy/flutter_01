import 'dart:ui';
import 'package:flutter/material.dart';
import 'baidu_model.dart';
import 'package:http/http.dart' as http;
import 'package:gbk2utf8/gbk2utf8.dart';
import 'splash.dart';
import 'test_page.dart';
import 'package:flare_flutter/flare_actor.dart';

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

  ///
  ///获取百度热搜数据
  ///
  getBaiduTopData() async {
    setState(() => _baidutopdata.clear());

    List index = List();
    List title = List();
    List<bool> tag1 = List();
    List<int> tag2 = List();

    http.Response response = await http.get('http://top.baidu.com/buzz?b=1');
    String body = gbk.decode(response.bodyBytes);

    ///
    ///正则取标题
    ///
    Iterable<Match> mtitle =
        RegExp('<a class="list-title" target="_blank" href=".*?>(.*?)</a>')
            .allMatches(body);
    for (Match m in mtitle) {
      title.add(m.group(1));
    }

    ///
    ///正则取搜索指数
    ///
    Iterable<Match> mindex =
        RegExp('<span class="icon-.*?">(.*?)</span>').allMatches(body);
    for (Match m in mindex) {
      index.add(m.group(1));
    }

    ///
    ///正则判断是否为新数据
    ///
    String tag1body = body.replaceAll(RegExp('\\s|\n'), '');
    Iterable<Match> mtag1 = RegExp(
            '<aclass="list-title"target="_blank"href=".*?>.*?</a>(.*?)<ahref')
        .allMatches(tag1body);
    for (Match m in mtag1) {
      tag1.add(m.group(1).isEmpty ? false : true);
    }

    ///
    ///正则判断搜索指数上升和下降
    ///
    Iterable<Match> mtag2 =
        RegExp('<span class="icon-(.*?)">').allMatches(body);
    for (Match m in mtag2) {
      tag2.add(m.group(1) == 'rise' ? 1 : 2);
    }

    ///
    ///依次添加到list中(延迟两秒)
    ///
    Future.delayed(Duration(milliseconds: 2000), () {
      setState(() {
        for (var i = 0; i < index.length; i++) {
          _baidutopdata.add(Baidu(index[i], title[i], tag1[i], tag2[i]));
        }
      });
    });

    ///
    ///数据获取完成的提示
    ///
    // if (flag) {
    //   Scaffold.of(context).showSnackBar(
    //     SnackBar(
    //       content: Row(
    //         children: <Widget>[
    //           Icon(Icons.sentiment_satisfied, size: 18),
    //           SizedBox(width: 8),
    //           Text('刷新成功！', style: TextStyle(fontSize: 18)),
    //         ],
    //       ),
    //       backgroundColor: Color(0xff242433),
    //       duration: Duration(milliseconds: 2000),
    //     ),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ///
              ///标题栏
              ///
              Container(
                margin: EdgeInsets.only(left: 28, top: 28, bottom: 14),
                child: Text(
                  '热点集',
                  style: TextStyle(
                    color: Color(0xff242433),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              ///
              ///顶部选项条
              ///
              Stack(
                children: <Widget>[
                  Container(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      children: <Widget>[
                        buildTopTab('百度', 1.0),
                        buildTopTab('抖音', 0.25),
                        buildTopTab('网易云音乐', 0.25),
                        buildTopTab('今日头条', 0.25),
                        buildTopTab('QQ看点', 0.25),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 40,
                      width: 56,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xfffafafa), Color(0x00ffffff)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 40,
                      width: 56,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xfffafafa), Color(0x00ffffff)],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft),
                      ),
                    ),
                  ),
                ],
              ),

              ///
              ///数据展示
              ///
              this._baidutopdata.length != 0
                  ? Expanded(
                      child: Stack(
                        children: <Widget>[
                          //列表数据载体
                          buildListItem(_baidutopdata),
                          //顶部虚化
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 56,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [Color(0xfffafafa), Color(0x00ffffff)],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter),
                              ),
                            ),
                          ),
                          //底部虚化
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 56,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [Color(0xfffafafa), Color(0x00ffffff)],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : buiidListPlaceholderUI(),
            ],
          ),

          ///
          ///小球操作按钮
          ///
          buildFab(),
        ],
      ),
    );
  }

  ///
  ///刷新部件
  ///
  Widget buiidListPlaceholderUI() {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Container(
          height: 56,
          width: 56,
          child: Opacity(
            opacity: 0.5,
            child: FlareActor(
              'assets/earth.flr',
              animation: 'ks',
            ),
          ),
        ),
      ),
    );
  }

  ///
  ///列表项
  ///
  Widget buildListItem(List<Baidu> baiduData) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: baiduData.length,
      itemBuilder: (BuildContext context, int i) {
        return Container(
          margin: EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 12),
          child: Row(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: i == 0
                      ? Colors.redAccent.withOpacity(0.25)
                      : i == 1
                          ? Colors.orangeAccent.withOpacity(0.25)
                          : i == 2
                              ? Colors.blueAccent.withOpacity(0.25)
                              : Colors.black.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Text(
                  (i + 1).toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: i == 0
                        ? Colors.redAccent
                        : i == 1
                            ? Colors.orangeAccent
                            : i == 2
                                ? Colors.blueAccent
                                : Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Splash(
                  child: Container(
                    margin: EdgeInsets.only(left: 24),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: i == 0 || i == 1 || i == 2
                          ? Colors.white
                          : Color(0xff242433).withOpacity(0.05),
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: i == 0 || i == 1 || i == 2
                          ? [
                              BoxShadow(
                                blurRadius: 1,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 1),
                              )
                            ]
                          : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          baiduData[i].title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  baiduData[i].tag2 == 1 ? '上升↑' : '下降↓',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: baiduData[i].tag2 == 1
                                          ? Colors.green
                                          : Colors.grey),
                                ),
                                SizedBox(width: 16),
                                Text(
                                  '新',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: baiduData[i].tag1 == true
                                        ? Colors.red.withOpacity(1)
                                        : Colors.red.withOpacity(0.25),
                                    decoration: baiduData[i].tag1 == true
                                        ? TextDecoration.none
                                        : TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '热度 : ' + baiduData[i].index,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => new TestPage(
                              title: baiduData[i].title,
                            ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ///
  ///顶部选项卡
  ///
  Widget buildTopTab(text, opacity) {
    return Opacity(
      opacity: opacity,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          margin: text == '百度'
              ? EdgeInsets.only(left: 24, right: 12)
              : text == 'QQ看点'
                  ? EdgeInsets.only(left: 12, right: 24)
                  : EdgeInsets.only(left: 12, right: 12),
          padding: EdgeInsets.only(left: 32, right: 32),
          decoration: BoxDecoration(
            color: Color(0xff242433).withOpacity(0.1),
            borderRadius: BorderRadius.circular(56),
          ),
          child: Text(
            text,
            style: TextStyle(
                color: Color(0xff242433).withOpacity(0.5),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  ///
  ///底部操作按钮
  ///
  Widget buildFab() {
    return Positioned(
      bottom: 24,
      right: 24,
      child: GestureDetector(
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(56),
              boxShadow: [
                BoxShadow(
                  color: Color(0xff242433).withOpacity(0.25),
                  blurRadius: 30,
                  offset: Offset(0, 30),
                )
              ]),
          child: Icon(
            Icons.refresh,
            color: Color(0xff242433),
          ),
        ),
        onTap: () {
          getBaiduTopData();
        },
      ),
    );
  }
}
