import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///
///关于系统的一些操作方法
///
class SystemUtils {
  ///
  ///设置系统状态栏的风格
  ///brightness:黑与白
  ///仅限安卓，IOS暂不支持
  ///
  static setStatusBarStyle(Brightness brightness) {
    TargetPlatform platform = defaultTargetPlatform;
    if (platform != TargetPlatform.iOS) {
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: brightness);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}