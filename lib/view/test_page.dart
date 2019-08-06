import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'webview_page.dart';

class TestPage extends StatefulWidget {
  TestPage({this.title}) : super();
  final String title;
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List _videoList = List();
  List _newList = List();
  int _videoPn = 0;
  int _newPn = 0;
  bool flag = true;
  double _videoOpacity = 0;
  double _newOpacity = 0;
  double _refreshBottom = -48;
  ScrollController _videoScrollController = ScrollController();
  ScrollController _newScrollController = ScrollController();
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    getBaiduDataNews(widget.title, 4, 0);

    //视频列表滑动到底加载更多数据
    _videoScrollController.addListener(() {
      if (_videoScrollController.position.pixels ==
          _videoScrollController.position.maxScrollExtent) {
        _videoPn += 10;
        getBaiduDataVedios(widget.title, _videoPn);
      }

      if (_videoScrollController.position.pixels / 100 <= 0.5 &&
          _videoScrollController.position.pixels / 100 >= -0.25) {
        if (_videoScrollController.position.pixels.toString().substring(0, 1) ==
            '-') {
          setState(() {
            _videoOpacity = -_videoScrollController.position.pixels / 100;
          });
        } else {
          setState(() {
            _videoOpacity = _videoScrollController.position.pixels / 100;
          });
        }
      }
    });

    _newScrollController.addListener(() {
      if (_newScrollController.position.pixels ==
          _newScrollController.position.maxScrollExtent) {
        _newPn += 10;
        getBaiduDataNews(widget.title, 4, _newPn);
      }

      if (_newScrollController.position.pixels / 100 <= 0.25 &&
          _newScrollController.position.pixels / 100 >= -0.25) {
        if (_newScrollController.position.pixels.toString().substring(0, 1) ==
            '-') {
          setState(() {
            _newOpacity = -_newScrollController.position.pixels / 100;
          });
        } else {
          setState(() {
            _newOpacity = _newScrollController.position.pixels / 100;
          });
        }
      }
    });

    //滑到当前页才加载数据
    _pageController.addListener(() {
      if (flag) if (_pageController.page >= 0.5) {
        flag = false;
        getBaiduDataVedios(widget.title, _videoPn);
      }
    });
  }

  ///
  ///wd：关键字
  ///pn：分页
  ///
  void getBaiduDataVedios(wd, pn) async {
    List data = List();
    var url =
        'https://www.baidu.com/sf/vsearch?word=$wd&pd=video&tn=vsearch&atn=index&pn=$pn&data_type=json&mod=5&p_type=1&rn=10&atn=index&lid=10915719651082432652&main_srcid=4295';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'User-Agent':
          'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1'
    };
    http.Response response = await http.get(url, headers: headers);
    // imgSrc duration play_count pubtime shareTitle source
    List videoList = json.decode(response.body)['data']['videoList'];
    for (var item in videoList) {
      data.add(item);
    }
    setState(() => _videoList.addAll(data));
  }

  ///
  ///wd：关键字
  ///rtt：排序 1=焦点 4=时间
  ///pn：分页
  ///
  void getBaiduDataNews(wd, rtt, pn) async {
    List<Map> data = List();
    Map<String, String> headers = {
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36'
    };
    var url =
        'https://www.baidu.com/s?tn=news&rtt=$rtt&bsst=1&cl=2&wd=$wd&pn=$pn&medium=2';
    http.Response response = await http.get(url, headers: headers);

    var replaceAll = response.body.replaceAll(RegExp('\\s|\n|<em>|</em>'), '');
    Iterable<Match> matchs =
        // " alt=".*?".*?>    <p class="c-author">
        RegExp('<divclass="result"id=.*?href="(.*?)"data-click.*?target="_blank">(.*?)</a>.*?src="(.*?)"alt=""/>(.*?)&nbsp;&nbsp;(.*?)</p>(.*?)<spanc')
            .allMatches(replaceAll);
    for (Match m in matchs) {
      Map<String, String> map = Map();
      map.addAll({
        'url': m.group(1),
        'title': m.group(2),
        'img': m.group(3),
        'autho': m.group(4),
        'time': m.group(5),
        'content': m.group(6)
      });
      data.add(map);
    }
    setState(() => _newList.addAll(data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    InkWell(
                      splashColor:
                          Theme.of(context).accentColor.withOpacity(0.1),
                      highlightColor: Colors.transparent,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(48),
                        bottomRight: Radius.circular(48),
                      ),
                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).accentColor.withOpacity(0.05),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(48),
                            bottomRight: Radius.circular(48),
                          ),
                        ),
                        child: Icon(
                          Icons.keyboard_backspace,
                          color: Theme.of(context).accentColor.withOpacity(.5),
                        ),
                      ),
                      onTap: () {
                        Future.delayed(Duration(milliseconds: 200), () {
                          Navigator.pop(context);
                        });
                      },
                    ),
                    SizedBox(width: 8),
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '(点击编辑)',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).accentColor.withOpacity(0.25),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 24, bottom: 8, left: 24),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '文章',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).accentColor.withOpacity(1),
                        ),
                      ),
                      SizedBox(width: 24),
                      Text(
                        '视频',
                        style: TextStyle(
                          fontSize: 14,
                          color:
                              Theme.of(context).accentColor.withOpacity(0.25),
                        ),
                      ),
                    ],
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: <Widget>[
                //     Container(
                //       height: 8,
                //       width: 8,
                //       color: Colors.red,
                //     ),
                //     Container(
                //       height: 8,
                //       width: 8,
                //       color: Colors.red,
                //     )
                //   ],
                // ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      _newList.length == 0 ? buildUI() : buildNewList(_newList),
                      _videoList.length == 0
                          ? buildUI()
                          : buildVideoList(_videoList),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 28,
              right: 28,
              child: GestureDetector(
                onTap: (){
                  print(_newScrollController.position.maxScrollExtent);
                },
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(48),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.24),
                        blurRadius: 24,
                        offset: Offset(0, 24),
                      )
                    ],
                  ),
                  child: Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColor,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 刷新等待
  Widget buildUI() {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: 40,
        height: 40,
        child: Opacity(
          opacity: 0.75,
          // child: FlareActor(
          //   'assets/earth.flr',
          //   animation: 'ks',
          // ),
          child: CircularProgressIndicator(
            strokeWidth: 3,
          ),
        ),
      ),
    );
  }

  //视频列表
  Widget buildVideoList(data) {
    return Container(
      child: Stack(
        children: <Widget>[
          ListView.builder(
            physics: BouncingScrollPhysics(),
            controller: _videoScrollController,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int i) {
              return Container(
                height:
                    window.physicalSize.width / window.devicePixelRatio / 2.25,
                margin: i == 0
                    ? EdgeInsets.only(top: 16, bottom: 16)
                    : i == data.length - 1
                        ? EdgeInsets.only(top: 16, bottom: 32)
                        : EdgeInsets.only(top: 16, bottom: 16),
                child: InkWell(
                  splashColor: Theme.of(context).accentColor.withOpacity(0.1),
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Future.delayed(Duration(milliseconds: 200), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => new WebViewPage(
                              data[i]['shareTitle']
                                  .toString()
                                  .replaceAll('', ''),
                              false),
                        ),
                      );
                    });
                  },
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.only(top: 8, bottom: 8),
                          padding:
                              EdgeInsets.only(left: 40, top: 16, bottom: 16),
                          width: window.physicalSize.width /
                                  window.devicePixelRatio /
                                  3 *
                                  2 -
                              28,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .accentColor
                                .withOpacity(0.025),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                data[i]['shareTitle']
                                    .toString()
                                    .replaceAll('', ''),
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.75),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 4, bottom: 4, left: 8, right: 8),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .accentColor
                                            .withOpacity(0.05),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Text(
                                      data[i]['source'],
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .accentColor
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 4, bottom: 4, left: 8, right: 8),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .accentColor
                                            .withOpacity(0.05),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Text(
                                      data[i]['pubtime'],
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .accentColor
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    '视频时长 : ',
                                    style: TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .accentColor
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                  Text(
                                    data[i]['duration'],
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            width: window.physicalSize.width /
                                    window.devicePixelRatio /
                                    3 +
                                56,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.25),
                                    BlendMode.multiply),
                                fit: BoxFit.cover,
                                image: NetworkImage(data[i]['imgSrc']),
                              ),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(24),
                                bottomRight: Radius.circular(24),
                              ),
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              ClipOval(
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.25),
                                  child: Icon(
                                    Icons.play_arrow,
                                    size: 32,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Container(
            height: 5,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(_videoOpacity),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  //文章列表
  Widget buildNewList(data) {
    return Container(
      child: Stack(
        children: <Widget>[
          ListView.builder(
            physics: BouncingScrollPhysics(),
            controller: _newScrollController,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int i) {
              return Container(
                padding: EdgeInsets.all(16),
                margin: i == 0
                    ? EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16)
                    : i == data.length - 1
                        ? EdgeInsets.only(
                            top: 16, bottom: 32, left: 16, right: 16)
                        : EdgeInsets.only(
                            top: 16, bottom: 16, left: 16, right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).accentColor.withOpacity(0.025),
                  // color: Colors.white.withOpacity(0.025),
                ),
                child: InkWell(
                  splashColor: Theme.of(context).accentColor.withOpacity(0.1),
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Future.delayed(Duration(milliseconds: 200), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              new WebViewPage(data[i]['title'], true),
                        ),
                      );
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        data[i]['title'],
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            color: Theme.of(context)
                                .accentColor
                                .withOpacity(0.75)),
                      ),
                      SizedBox(height: 16),
                      Text(
                        data[i]['content'],
                        style: TextStyle(
                          letterSpacing: 1,
                          color: Theme.of(context).accentColor.withOpacity(0.5),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Stack(
                            alignment: Alignment.centerLeft,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    left: 36, top: 4, bottom: 4, right: 8),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(56),
                                ),
                                child: Text(
                                  data[i]['autho'],
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .accentColor
                                          .withOpacity(0.75)),
                                ),
                              ),
                              Container(
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      data[i]['img'],
                                    ),
                                  ),
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(32),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 16,
                                        color: Colors.black.withOpacity(0.16),
                                        offset: Offset(0, 16)),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Text(
                            data[i]['time'],
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          Container(
            height: 5,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(_newOpacity),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: _refreshBottom,
            right: 24,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(48),
                color: Theme.of(context).accentColor,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff242433).withOpacity(0.5),
                    blurRadius: 25,
                    offset: Offset(0, 25),
                  )
                ],
              ),
              child: Icon(
                Icons.refresh,
                color: Theme.of(context).primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
