import 'dart:ui';

import 'package:comical_music/model1/Song.dart';
import 'package:comical_music/model1/SongList.dart';
import 'package:comical_music/pages/play_list/song_list_desc_dialog.dart';
import 'package:comical_music/utils/net_utils1.dart';
import 'package:comical_music/widgets/widget_future_builder.dart';
import 'package:comical_music/widgets/widget_song_list_cover.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:comical_music/model/comment_head.dart';
import 'package:comical_music/model/music.dart';
import 'package:comical_music/model/play_list.dart';
import 'package:comical_music/model/recommend.dart';
import 'package:comical_music/model/song.dart';
import 'package:comical_music/pages/comment/comment_type.dart';
import 'package:comical_music/pages/play_list/play_list_desc_dialog.dart';
import 'package:comical_music/provider/play_songs_model.dart';
import 'package:comical_music/utils/navigator_util.dart';
import 'package:comical_music/utils/net_utils.dart';
import 'package:comical_music/widgets/common_text_style.dart';
import 'package:comical_music/widgets/h_empty_view.dart';
import 'package:comical_music/widgets/v_empty_view.dart';
import 'package:comical_music/widgets/widget_footer_tab.dart';
import 'package:comical_music/widgets/widget_music_list_item.dart';
import 'package:comical_music/widgets/widget_play.dart';
import 'package:comical_music/widgets/widget_round_img.dart';
import 'package:comical_music/widgets/widget_play_list_app_bar.dart';
import 'package:comical_music/widgets/widget_play_list_cover.dart';
import 'package:comical_music/widgets/widget_sliver_future_builder.dart';
import 'package:provider/provider.dart';

import '../../application.dart';

class SongListPage extends StatefulWidget {
  SongList data;

  SongListPage(SongList data) {
    this.data = data;
  }

  @override
  _SongListPageState createState() => _SongListPageState(data);
}

class _SongListPageState extends State<SongListPage> {
  double _expandedHeight = ScreenUtil().setWidth(630);
  SongList _data;

  _SongListPageState(this._data) {
    //print(_data);
  }

  /// 构建歌单简介
  Widget buildDescription(SongList data) {
    return Container(
        child: GestureDetector(
          onTap: () {
            showGeneralDialog(
              context: context,
              pageBuilder: (BuildContext buildContext,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return SongListDescDialog(data);
              },
              barrierDismissible: true,
              barrierLabel:
              MaterialLocalizations
                  .of(context)
                  .modalBarrierDismissLabel,
              transitionDuration: const Duration(milliseconds: 150),
              transitionBuilder: _buildMaterialDialogTransitions,
            );
          },
          child: data != null && data.introduction != null
              ? Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  data.introduction,
                  style: smallWhite70TextStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white70,
              ),
            ],
          )
              : Container(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                bottom:
                ScreenUtil().setWidth(80) + Application.bottomBarHeight),
            child: CustomFutureBuilder<SongList>(
                futureFunc: NetUtils1.getSongList,
                params: {
                  'context': context,
                  'songListId': _data.id,
                },
                builder: (context, songList) {
                  //print(songList);
                  _data=songList;
                  return CustomScrollView(
                    slivers: <Widget>[
                      PlayListAppBarWidget(
                        sigma: 20,
                        playOnTap: (model) {
                          playSongs(model, 0);
                        },
                        content: SafeArea(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: ScreenUtil().setWidth(35),
                              right: ScreenUtil().setWidth(35),
                              top: ScreenUtil().setWidth(120),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    PlayListCoverWidget(
                                      songList.image.path,
                                      width: 250,
                                    ),
                                    HEmptyView(20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            songList.name,
                                            softWrap: true,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: mWhiteBoldTextStyle,
                                          ),
                                          VEmptyView(10),
                                          Row(
                                            children: <Widget>[
                                              //Container(),
                                              songList == null
                                                  ? Container()
                                                  : RoundImgWidget(
                                                  songList.creator.image.path,
                                                  40),
                                              HEmptyView(5),
                                              Expanded(
                                                child: songList == null
                                                    ? Container()
                                                    : Text(
                                                  songList.creator.username,
                                                  maxLines: 1,
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  style:
                                                  commonWhite70TextStyle,
                                                ),
                                              ),
                                              songList == null
                                                  ? Container()
                                                  : Icon(
                                                Icons
                                                    .keyboard_arrow_right,
                                                color: Colors.white70,
                                              ),
                                            ],
                                          ),
                                          VEmptyView(10),
                                          buildDescription(songList),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                VEmptyView(15),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setWidth(12)),
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: <Widget>[
                                      //TODO
//                                FooterTabWidget('images/icon_comment.png',
//                                    '${_data == null ? "评论" : _data.commentCount}',
//                                        () {
//                                      NavigatorUtil.goCommentPage(context,
//                                          data: CommentHead(
//                                              _data.coverImgUrl,
//                                              _data.name,
//                                              _data.creator.nickname,
//                                              _data.commentCount,
//                                              _data.id,
//                                              CommentType.playList.index));
//                                    }),
                                      FooterTabWidget(
                                          'images/icon_download.png',
                                          '${songList == null ? "收藏" : songList
                                              .addCount}',
                                              () {}),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        expandedHeight: _expandedHeight,
                        backgroundImg: songList.image.path,
                        title: songList.name,
                        count: songList == null ? null : songList.songs.length,
                      ),
                      Consumer<PlaySongsModel>(
                          builder: (context, model, child) {
                            return SliverList(
                                delegate:
                                SliverChildBuilderDelegate((context, index) {
                                  var d1 = songList.songs[index];
                                  //print(songList.songs[index]);
                                  return WidgetMusicListItem(
                                  d1,
                                  index + 1,
                                  onTap: ()
                                  {
                                    playSongs(model, index);
                                  },);
                                }, childCount: songList.songs.length));
                          }),
                    ],
                  );
                }),
          ),
          PlayWidget(),
        ],
      ),
    );
  }

  void playSongs(PlaySongsModel model, int index) {
    model.playSongs(
      _data.songs,
      index: index,
    );
    NavigatorUtil.goPlaySongsPage(context);
  }

  Widget _buildMaterialDialogTransitions(BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }
}
