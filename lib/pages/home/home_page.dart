import 'package:flutter/material.dart';
import 'package:comical_music/provider/user_model.dart';
import 'package:comical_music/utils/navigator_util.dart';
import 'package:comical_music/widgets/v_empty_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:comical_music/widgets/widget_play.dart';
import 'package:comical_music/widgets/widget_round_img.dart';
import 'package:provider/provider.dart';
import '../../application.dart';
import 'discover/discover_page.dart';
import 'event/event_page.dart';
import 'my/my_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  Future<bool> _openAlertDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, //// user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('提示'),
          content: Text('是否注销?'),
          actions: <Widget>[
            FlatButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            FlatButton(
              child: Text('确认'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 设置没有高度的 appbar，目的是为了设置状态栏的颜色
      appBar: PreferredSize(
        child: AppBar(
          elevation: 0,
        ),
        preferredSize: Size.zero,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Padding(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Positioned(
                        left: 20.w,
                        child: Consumer<UserModel>(
                          builder: (_, model, __) {
                            var user = model.user;
                            return GestureDetector(
                              onTap: () => {
                                _openAlertDialog(context).then((value) {
                                  if(value){
                                    NavigatorUtil.goLoginPage(context);
                                  }
                                })

                              },
                              child:
                                  RoundImgWidget(user.image.path, 140.w),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(150)),
                        child: TabBar(
                          labelStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          unselectedLabelStyle: TextStyle(fontSize: 14),
                          indicator: UnderlineTabIndicator(),
                          controller: _tabController,
                          tabs: [
                            //TODO
                            Tab(
                              text: '动态',
                            ),
                            Tab(
                              text: '发现',
                            ),
                            Tab(
                              text: '我的',
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 20.w,
                        child: IconButton(
                          icon: Icon(
                            Icons.search,
                            size: 50.w,
                            color: Colors.black87,
                          ),
                          onPressed: () {
                            NavigatorUtil.goSearchPage(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  VEmptyView(20),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        EventPage(),
                        DiscoverPage(),
                        MyPage(),
                      ],
                    ),
                  ),
                ],
              ),
              padding: EdgeInsets.only(
                  bottom:
                      ScreenUtil().setWidth(80) + Application.bottomBarHeight),
            ),
            PlayWidget(),
          ],
        ),
      ),
    );
  }
}
