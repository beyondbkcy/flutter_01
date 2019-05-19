import 'package:flutter/material.dart';
import './utils/System.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemUtils.setStatusBarStyle(Brightness.light);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '网易云音乐-重设计',
      home: Scaffold(
        backgroundColor: Color(0xff1E1F2D),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 16, left: 24),
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
      ),
    );
  }

// 热门搜索
  Container buildHotSearch() {
    return Container(
      padding: EdgeInsets.only(left: 0, top: 16),
      child: Wrap(
        alignment: WrapAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 16, bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(100),
            ),
            padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
            child: Text(
              '孤单心事',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 16, bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(100),
            ),
            padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
            child: Text(
              '青春住了谁',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 16, bottom: 16), 
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(100),
            ),
            padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
            child: Text(
              'Taylor Swift',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 16, bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(100),
            ),
            padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
            child: Text(
              '袁娅维远方韵律',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 16, bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(100),
            ),
            padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
            child: Text(
              '复仇者联盟',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 16, bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(100),
            ),
            padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
            child: Text(
              'bad guy',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 16, bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(100),
            ),
            padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
            child: Text(
              'horizon',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 16, bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(100),
            ),
            padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
            child: Text(
              'better now',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 16, bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(100),
            ),
            padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
            child: Text(
              '开场秒下',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 16, bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(100),
            ),
            padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
            child: Text(
              'waiting for',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          )
        ],
      ),
    );
  }

// 历史搜索
  Container buildHistoricalSearch() {
    return Container(
      padding: EdgeInsets.only(left: 0, top: 16),
      child: Wrap(
        alignment: WrapAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 16, bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(100),
            ),
            padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
            child: Text(
              'Beyond',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 16, bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(100),
            ),
            padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
            child: Text(
              '你的酒馆对我打了烊',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 16, bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(100),
            ),
            padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
            child: Text(
              '灰色轨迹',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 16, bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(100),
            ),
            padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
            child: Text(
              '大碗宽面',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
