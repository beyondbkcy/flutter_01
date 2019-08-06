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

  //数字转中文
  // static numToChinese(double num) {
  //   final List<String> CN_UPPER_NUMBER = [
  //     "零",
  //     "壹",
  //     "贰",
  //     "叁",
  //     "肆",
  //     "伍",
  //     "陆",
  //     "柒",
  //     "捌",
  //     "玖"
  //   ];
  //   final List<String> CN_UPPER_MONETRAY_UNIT = [
  //     "分",
  //     "角",
  //     "圆",
  //     "拾",
  //     "佰",
  //     "仟",
  //     "万",
  //     "拾",
  //     "佰",
  //     "仟",
  //     "亿",
  //     "拾",
  //     "佰",
  //     "仟",
  //     "兆",
  //     "拾",
  //     "佰",
  //     "仟"
  //   ];
  //   final String CN_FULL = "整";
  //   final String CN_NEGATIVE = "负";
  //   final String CN_ZEOR_FULL = "零圆" + CN_FULL;
  //   double sign = num.sign;
  //   if (sign == num) {
  //     return CN_ZEOR_FULL;
  //   }
  //   if (num.toStringAsFixed(0).length > 15) {
  //     return '超出最大限额';
  //   }
  //   num = num * 100;
  //   int tempValue = int.parse(num.toStringAsFixed(0)).abs();

  //   int p = 10;
  //   int i = -1;
  //   String CN_UP = '';
  //   bool lastZero = false;
  //   bool finish = false;
  //   bool tag = false;
  //   bool tag2 = false;
  //   while (!finish) {
  //     if (tempValue == 0) {
  //       break;
  //     }
  //     int positionNum = tempValue % p;
  //     double n = (tempValue - positionNum) / 10;
  //     tempValue = int.parse(n.toStringAsFixed(0));
  //     String tempChinese = '';
  //     i++;
  //     if (positionNum == 0) {
  //       if (CN_UPPER_MONETRAY_UNIT[i] == "万" ||
  //           CN_UPPER_MONETRAY_UNIT[i] == "亿" ||
  //           CN_UPPER_MONETRAY_UNIT[i] == "兆" ||
  //           CN_UPPER_MONETRAY_UNIT[i] == "圆") {
  //         if (lastZero && tag2) {
  //           CN_UP = CN_UPPER_NUMBER[0] + CN_UP;
  //         }
  //         CN_UP = CN_UPPER_MONETRAY_UNIT[i] + CN_UP;
  //         lastZero = false;
  //         tag = true;
  //         continue;
  //       }
  //       if (!lastZero) {
  //         lastZero = true;
  //       } else {
  //         continue;
  //       }
  //     } else {
  //       if (lastZero && !tag && tag2) {
  //         CN_UP = CN_UPPER_NUMBER[0] + CN_UP;
  //       }
  //       tag = false;
  //       tag2 = true;
  //       lastZero = false;
  //       tempChinese = CN_UPPER_NUMBER[positionNum] + CN_UPPER_MONETRAY_UNIT[i];
  //     }
  //     CN_UP = tempChinese + CN_UP;
  //   }
  //   if (sign < 0) {
  //     CN_UP = CN_NEGATIVE + CN_UP;
  //   }
  //   return CN_UP;
  // }
}
