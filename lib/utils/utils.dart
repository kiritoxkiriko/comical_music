import 'package:cached_network_image/cached_network_image.dart';
import 'package:comical_music/model1/Singer.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:comical_music/model1/Lyric.dart';

class Utils {
  static void showToast(String msg) {
    Fluttertoast.showToast(msg: msg, gravity: ToastGravity.CENTER);
  }

  static Widget showNetImage(String url,
      {double width, double height, BoxFit fit}) {
    return Image(
      image: ExtendedNetworkImageProvider(url, cache: true),
      width: width,
      height: height,
      fit: fit,
    );
  }

  /// 格式化歌词
  static List<Lyric> formatLyric(String lyricStr) {
    RegExp reg = RegExp(r"^\[\d{2}");

    List<Lyric> result =
        lyricStr.split("\n").where((r) => reg.hasMatch(r)).map((s) {
      String time = s.substring(0, s.indexOf(']'));
      String lyric = s.substring(s.indexOf(']') + 1);
      time = s.substring(1, time.length );
      int minSeparatorIndex = time.indexOf(":");
      int millSeparatorIndex = time.indexOf(".");
//      print(s);
//      print(time);
//      print((minSeparatorIndex + 1).toString()+":"+millSeparatorIndex.toString());
//      print(time.substring(millSeparatorIndex + 1));
      return Lyric(
        lyric,
        startTime: Duration(
          minutes: int.parse(
            time.substring(0, minSeparatorIndex),
          ),
          seconds: int.parse(
              time.substring(minSeparatorIndex + 1, (millSeparatorIndex<0? time.length : millSeparatorIndex))),
          milliseconds: millSeparatorIndex<0? 0: int.parse(time.substring(millSeparatorIndex + 1,time.length)),
        ),
      );
    }).toList();

    for (int i = 0; i < result.length - 1; i++) {
      result[i].endTime = result[i + 1].startTime;
    }
    result[result.length - 1].endTime = Duration(hours: 1);
    return result;
  }

  /// 查找歌词
  static int findLyricIndex(double curDuration, List<Lyric> lyrics) {
    for (int i = 0; i < lyrics.length; i++) {
      if (curDuration >= lyrics[i].startTime.inMilliseconds &&
          curDuration <= lyrics[i].endTime.inMilliseconds) {
        return i;
      }
    }
    return 0;
  }

  ///转换singer名字
  static String convertSingerNames(List<Singer> singers){
    String s="";
    singers.forEach((e) {
      s+="/"+e.name;
    });
    s=s.replaceFirst("/", "");
    return s;
  }
}
