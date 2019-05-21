import 'package:flutter/material.dart';
import './utils/System.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemUtils.setStatusBarStyle(Brightness.light);
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: '网易云音乐',
      home: buildHome(),
    );
  }

//app主体
  Scaffold buildHome() => Scaffold(
        backgroundColor: Colors.deepPurple,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 24, left: 24),
                child: Text(
                  '热门搜索',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              buildHotSearch(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 24),
                    child: Text(
                      '历史搜索',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 24),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 24,
                    ),
                  )
                ],
              ),
              buildHistoricalSearch()
            ],
          ),
        ),
      );

// 热门搜索
  Container buildHotSearch() => Container(
        padding: EdgeInsets.only(left: 0, top: 16),
        child: Wrap(
          alignment: WrapAlignment.start,
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

// 热门搜索小部件
  Container buildContainer1(str) => Container(
        margin: EdgeInsets.only(right: 16, bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
        child: Text(
          str,
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      );

// 历史搜索
  Container buildHistoricalSearch() => Container(
        padding: EdgeInsets.only(left: 0, top: 16),
        child: Wrap(
          alignment: WrapAlignment.start,
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

//历史搜索小部件
  Container buildContainer2(str) => Container(
        margin: EdgeInsets.only(right: 16, bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
        child: Text(
          str,
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      );
}
