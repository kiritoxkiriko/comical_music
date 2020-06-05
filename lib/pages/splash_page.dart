import 'package:comical_music/model1/ResponseData.dart';
import 'package:comical_music/utils/net_utils1.dart';
import 'package:flutter/material.dart';
import 'package:comical_music/application.dart';
import 'package:comical_music/model1/Song.dart';
import 'package:comical_music/model1/User.dart';

import 'package:comical_music/provider/play_songs_model.dart';
import 'package:comical_music/provider/user_model.dart';
import 'package:comical_music/utils/fluro_convert_utils.dart';
import 'package:comical_music/utils/navigator_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:comical_music/utils/net_utils.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController _logoController;
  Tween _scaleTween;
  CurvedAnimation _logoAnimation;

  @override
  void initState() {
    super.initState();
    _scaleTween = Tween(begin: 0, end: 1);
    _logoController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..drive(_scaleTween);
    Future.delayed(Duration(milliseconds: 500), () {
      _logoController.forward();
    });
    _logoAnimation =
        CurvedAnimation(parent: _logoController, curve: Curves.easeOutQuart);

    _logoController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: 500), () {
          goPage();
        });
      }
    });
  }

  void goPage() async{
    await Application.initSp();
    //Application.sp.setString("token", "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1OTE4MjAwNTAsInVzZXJJZCI6MX0.HGWixbMas2scECd7ORUVi8o4WX-IspqWTMkxrbBZ-KM");
    UserModel userModel = Provider.of<UserModel>(context);
    userModel.initUser();
    PlaySongsModel playSongsModel = Provider.of<PlaySongsModel>(context);
    // 判断是否有保存的歌曲列表
    if(Application.sp.containsKey('playing_songs')){
      List<String> songs = Application.sp.getStringList('playing_songs');
      playSongsModel.addSongs(songs.map((s) => Song.fromJson(FluroConvertUtils.string2map(s))).toList());
      int index = Application.sp.getInt('playing_index');
      playSongsModel.curIndex = index;
    }
    if (userModel.user != null) {
//      await NetUtils.refreshLogin(context).then((value){
//        if(ResponseData.fromJson(value.data).data != null){
//          userModel.saveToken(ResponseData.fromJson(value.data).data);
          NavigatorUtil.goHomePage(context);
//        }
//      });
      //Provider.of<P>(context).user = userModel.user;
    }else{
      NavigatorUtil.goLoginPage(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    NetUtils.init();
    NetUtils1.init();
    ScreenUtil.init(context, width: 750, height: 1334);
    final size = MediaQuery.of(context).size;
    Application.screenWidth = size.width;
    Application.screenHeight = size.height;
    Application.statusBarHeight = MediaQuery.of(context).padding.top;
    Application.bottomBarHeight = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: ScaleTransition(
          scale: _logoAnimation,
          child: Hero(
            tag: 'logo',
            child: Image.asset('images/icon_logo.png'),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _logoController.dispose();
  }
}
