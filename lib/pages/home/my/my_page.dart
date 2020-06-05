import 'package:comical_music/model1/SongList.dart';
import 'package:comical_music/provider/song_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:comical_music/model/play_list.dart';
import 'package:comical_music/model/recommend.dart';
import 'package:comical_music/pages/home/my/playlist_title.dart';

import 'package:comical_music/provider/user_model.dart';
import 'package:comical_music/utils/navigator_util.dart';
import 'package:comical_music/utils/net_utils.dart';
import 'package:comical_music/utils/utils.dart';
import 'package:comical_music/widgets/common_text_style.dart';
import 'package:comical_music/widgets/rounded_net_image.dart';
import 'package:comical_music/widgets/widget_create_play_list.dart';
import 'package:comical_music/widgets/widget_play_list_menu.dart';
import 'package:provider/provider.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  Map<String, String> topMenuData = {

  };

  List<String> topMenuKeys;
  bool selfPlayListOffstage = false;
  bool collectPlayListOffstage = false;
  SongListModel _songListModel;

  @override
  void initState() {
    super.initState();
    topMenuKeys = topMenuData.keys.toList();
    WidgetsBinding.instance.addPostFrameCallback((d){
      if(mounted) {
        _songListModel = Provider.of<SongListModel>(context);
        _songListModel.getSelfSongListData(context);
      }
      print(_songListModel==null);
      //print("xdbxbbxb");
    });
    //print("awdawdawd");
  }

//  Widget _buildTopMenu() {
//    return ListView.separated(
//      shrinkWrap: true,
//      padding: EdgeInsets.zero,
//      physics: NeverScrollableScrollPhysics(),
//      itemBuilder: (context, index) {
//        var curKey = topMenuKeys[index];
//        var curValue = topMenuData[topMenuKeys[index]];
//        return Container(
//          height: ScreenUtil().setWidth(110),
//          alignment: Alignment.center,
//          child: Row(
//            children: <Widget>[
//              Container(
//                width: ScreenUtil().setWidth(140),
//                child: Align(
//                  child: Image.asset(
//                    curValue,
//                    width: ScreenUtil().setWidth(100),
//                    fit: BoxFit.fitWidth,
//                  ),
//                ),
//              ),
//              Expanded(
//                child: Text(
//                  curKey,
//                  style: commonTextStyle,
//                ),
//              )
//            ],
//          ),
//        );
//      },
//      separatorBuilder: (context, index) {
//        return Container(
//          color: Colors.grey,
//          margin: EdgeInsets.only(left: ScreenUtil().setWidth(140)),
//          height: ScreenUtil().setWidth(0.3),
//        );
//      },
//      itemCount: 5,
//    );
//  }

  /// 构建「我创建的歌单」「收藏的歌单」
  Widget _buildSongListItem(List<SongList> data) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var curSongList = data[index];
          return ListTile(
            onTap: () {
              NavigatorUtil.goSongListPage(context,
                  data: curSongList);
            },
            contentPadding: EdgeInsets.zero,
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(5)),
              child: Text(curSongList.name),
            ),
            subtitle: Text(
              '${curSongList.songs.length}首',
              style: smallGrayTextStyle,
            ),
            leading: RoundedNetImage(
              curSongList.image.path,
              width: 110,
              height: 110,
              radius: ScreenUtil().setWidth(12),
            ),
            trailing: SizedBox(
              height: ScreenUtil().setWidth(50),
              width: ScreenUtil().setWidth(70),
              child: IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.grey,
                ),
                onPressed: () {
                  showModalBottomSheet<bool>(
                          context: context,
                          builder: (context) {
                            return PlayListMenuWidget(curSongList, _songListModel);
                          },
                          backgroundColor: Colors.transparent)
                      .then((v) {
                    if (v != null) {
                      // 1 为删除
                      if(v==true) {
                        Utils.showToast('删除成功');
                        _songListModel.deleteSongList(curSongList);
                      }
                    }
                  });
                },
                padding: EdgeInsets.zero,
              ),
            ),
          );
        },
        itemCount: data.length);
  }

  /// 创建我收藏的歌
  Widget _buildFavoriteSongListItem(SongList data) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var curSongList = data;
          return ListTile(
            onTap: () {
              NavigatorUtil.goSongListPage(context,
                  data: curSongList);
            },
            contentPadding: EdgeInsets.zero,
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(5)),
              child: Text(curSongList.name),
            ),
            subtitle: Text(
              '${curSongList.songs.length}首',
              style: smallGrayTextStyle,
            ),
            leading: RoundedNetImage(
              curSongList.image.path,
              width: 110,
              height: 110,
              radius: ScreenUtil().setWidth(12),
            ),
          );
        },
        itemCount: 1);
  }

  Widget _realBuildPlayList() {
    //print("asdasdasdas");

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        PlaylistTitle("我喜欢的歌曲", null, () {
          setState(() {
          });
        }, () {},
        ),
        Offstage(
          offstage: false,
          child: _buildFavoriteSongListItem(_songListModel.myFavoriteSong),
        ),
        PlaylistTitle("创建的歌单", _songListModel.selfCreateSongList.length, () {
          setState(() {
            selfPlayListOffstage = !selfPlayListOffstage;
          });
        }, () {},
        ),
        Offstage(
          offstage: selfPlayListOffstage,
          child: _buildSongListItem(_songListModel.selfCreateSongList),
        ),
        PlaylistTitle(
          "收藏的歌单",
          _songListModel.collectSongList.length,
          () {
            setState(() {
              collectPlayListOffstage = !collectPlayListOffstage;
            });
          },
          () {},
        ),
        Offstage(
          offstage: collectPlayListOffstage,
          child: _buildSongListItem(_songListModel.collectSongList),
        ),
      ],
    );
  }

  /// 构建歌单
  Widget _buildPlayList() {
    //print("zcxzcxz");
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
      child: _realBuildPlayList(),
    );
  }

//  /// 创建歌单
//  void _createPlaylist(String name, bool isPrivate) async {
//    NetUtils.createPlaylist(context,
//            params: {'name': name, 'privacy': isPrivate ? '10' : null})
//        .catchError((e) {
//      Utils.showToast('创建失败');
//    }).then((result) {
//      Utils.showToast('创建成功');
//      Navigator.of(context).pop();
//      _songListModel.addPlayList(result.playlist..creator = _songListModel.selfCreatePlayList[0].creator);
//    });
//  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //_buildTopMenu(),
            Container(
              color: Color(0xfff5f5f5),
              height: ScreenUtil().setWidth(25),
            ),
            _songListModel == null ? Container(
              height: ScreenUtil().setWidth(400),
              alignment: Alignment.center,
              child: CupertinoActivityIndicator(),
            ) : _buildPlayList(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
