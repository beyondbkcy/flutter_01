import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:http/http.dart' as http;

class TestPage extends StatefulWidget {
  TestPage({this.title}) : super();
  final String title;
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List _videoList = [];
  int pn = 0;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    getBaiduDataVedios(pn);
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        setState(() => pn += 10);
        getBaiduDataVedios(pn);
      }
    });
  }

  void getBaiduDataVedios(pn) async {
    var url =
        'https://www.baidu.com/sf/vsearch?word=${widget.title}&pd=video&tn=vsearch&atn=index&pn=$pn&data_type=json&mod=5&p_type=1&rn=10&atn=index&lid=10915719651082432652&main_srcid=4295';
    http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'User-Agent':
            'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1'
      },
    );
    // imgSrc duration play_count pubtime shareTitle source
    List videoList = json.decode(response.body)['data']['videoList'];
    setState(() {
      for (var item in videoList) {
        _videoList.add(item);
      }
    });

    // for (var item in videoList) {
    //   print(item['shareTitle']+'>>>>>>>>>>>>>>>>>>>>>>'+item['imgSrc']);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 8, top: 8),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        splashColor: Colors.black.withOpacity(0.1),
                        highlightColor: Colors.transparent,
                        borderRadius: BorderRadius.circular(56),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Icon(Icons.arrow_back),
                        ),
                        onTap: () {
                          new Future.delayed(Duration(milliseconds: 100), () {
                            Navigator.pop(context);
                          });
                        },
                      ),
                      SizedBox(width: 8),
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        '新闻',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff242433).withOpacity(1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '视频',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff242433).withOpacity(0.1),
                          fontWeight: FontWeight.bold,
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
                    child: _videoList.length == 0
                        ? buildUI()
                        : buildList2(_videoList))
              ],
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
        width: 56,
        height: 56,
        child: Opacity(
          opacity: 0.5,
          child: FlareActor(
            'assets/earth.flr',
            animation: 'ks',
          ),
        ),
      ),
    );
  }

  Widget buildList2(data) {
    return Container(
      child: ListView.builder(
        controller: _controller,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int i) {
          return Container(
            height: window.physicalSize.width / window.devicePixelRatio / 2,
            margin: i == 0
                ? EdgeInsets.only(top: 32, bottom: 16)
                : i == data.length - 1
                    ? EdgeInsets.only(top: 16, bottom: 32)
                    : EdgeInsets.only(top: 16, bottom: 16),
            child: Stack(
              children: <Widget>[
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
                          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.multiply),
                          fit: BoxFit.cover,
                          image: NetworkImage(data[i]['imgSrc']),
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                    ),
                    Stack(
                      children: <Widget>[
                        ClipOval(
                          child: Container(
                            width: 48,
                            height: 48,
                            color: Colors.white.withOpacity(0.25),
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
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.only(top: 8, bottom: 8),
                    padding: EdgeInsets.all(16),
                    width: window.physicalSize.width /
                            window.devicePixelRatio /
                            3 *
                            2 -
                        28,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            offset: Offset(0, 15),
                            blurRadius: 15,
                          )
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          data[i]['shareTitle'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              '来源 : ',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.25),
                              ),
                            ),
                            Text(
                              data[i]['source'],
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              '时间 : ',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.25),
                              ),
                            ),
                            Text(
                              data[i]['pubtime'],
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              '视频时长 : ',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.25),
                              ),
                            ),
                            Text(
                              data[i]['duration'],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget testUI(){
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext c,int i){
        return Dismissible(
          
        );
      },
    );
  }
}
