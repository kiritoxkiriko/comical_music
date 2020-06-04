import 'dart:io';

import 'package:comical_music/model1/Post.dart';
import 'package:comical_music/model1/Song.dart';
import 'package:extended_image/extended_image.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:comical_music/model/comment_head.dart';
import 'package:comical_music/model/recommend.dart';
import 'package:comical_music/pages/look_img_page.dart';
import 'package:comical_music/route/routes.dart';
import 'package:comical_music/route/transparent_route.dart';
import 'package:comical_music/utils/fluro_convert_utils.dart';

import '../application.dart';

class NavigatorUtil {
  static _navigateTo(BuildContext context, String path,
      {bool replace = false,
      bool clearStack = false,
      Duration transitionDuration = const Duration(milliseconds: 250),
      RouteTransitionsBuilder transitionBuilder}) {
    Application.router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        transitionDuration: transitionDuration,
        transitionBuilder: transitionBuilder,
        transition: TransitionType.material);
  }

  /// 登录页
  static void goLoginPage(BuildContext context) {
    _navigateTo(context, Routes.login, clearStack: true);
  }

  /// 首页
  static void goHomePage(BuildContext context) {
    _navigateTo(context, Routes.home, clearStack: true);
  }

  /// 每日推荐歌曲
  static void goDailySongsPage(BuildContext context) {
    _navigateTo(context, Routes.dailySongs);
  }

  /// 歌单详情
  static void goPlayListPage(BuildContext context, {@required Recommend data}) {
    _navigateTo(context,
        "${Routes.playList}?data=${FluroConvertUtils.object2string(data)}");
  }

  /// 排行榜首页
  static void goTopListPage(BuildContext context) {
    _navigateTo(context, Routes.topList);
  }

  /// 播放歌曲页面
  static void goPlaySongsPage(BuildContext context) {
    _navigateTo(context, Routes.playSongs);
  }

  /// 评论页面
  static void goCommentPage(BuildContext context,
      {@required Song song}) {
    _navigateTo(context,
        "${Routes.songComment}?song=${FluroConvertUtils.object2string(song)}");
  }

  static void goReplyPage(BuildContext context,
      {@required Post post}) {
    _navigateTo(context,
        "${Routes.reply}?post=${FluroConvertUtils.object2string(post)}");
  }


  /// 歌曲评论页面
  static void goSongCommentPage(BuildContext context,
      {@required Song song}) {
    _navigateTo(context,
        "${Routes.songComment}?song=${FluroConvertUtils.object2string(song)}");
  }

  /// 搜索页面
  static void goSearchPage(BuildContext context) {
    _navigateTo(context, Routes.search);
  }

  /// 查看图片页面
  static void goLookImgPage(
      BuildContext context, List<String> imgs, int index) {
//    Application.router.navigateTo(context, '${Routes.lookImg}?imgs=${FluroConvertUtils.object2string(imgs.join(','))}&index=$index', transitionBuilder: (){});
//    _navigateTo(context, '${Routes.lookImg}?imgs=${FluroConvertUtils.object2string(imgs.join(','))}&index=$index');
//    _navigateTo(context, '${Routes.lookImg}');
    Navigator.push(
      context,
        TransparentRoute(builder: (_) => LookImgPage(imgs, index),),
    );
  }

  /// 用户详情页面
  static void goUserDetailPage(BuildContext context, int userId) {
    _navigateTo(context, "${Routes.userDetail}?id=$userId");
  }

}
