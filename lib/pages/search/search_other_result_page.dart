import 'package:comical_music/model1/Song.dart';
import 'package:comical_music/model1/SongList.dart';
import 'package:comical_music/model1/User.dart';
import 'package:comical_music/utils/net_utils1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:comical_music/provider/play_songs_model.dart';
import 'package:comical_music/utils/navigator_util.dart';
import 'package:comical_music/utils/number_utils.dart';
import 'package:comical_music/widgets/common_text_style.dart';
import 'package:comical_music/widgets/h_empty_view.dart';
import 'package:comical_music/widgets/v_empty_view.dart';
import 'package:comical_music/widgets/widget_load_footer.dart';
import 'package:comical_music/widgets/widget_music_list_item.dart';
import 'package:comical_music/widgets/widget_search_play_list.dart';
import 'package:provider/provider.dart';

typedef LoadMoreWidgetBuilder<T> = Widget Function(T data);

class SearchOtherResultPage extends StatefulWidget {
  final String type;
  final String keywords;

  SearchOtherResultPage(this.type, this.keywords);

  @override
  _SearchOtherResultPageState createState() => _SearchOtherResultPageState();
}

class _SearchOtherResultPageState extends State<SearchOtherResultPage>
    with AutomaticKeepAliveClientMixin {
  int _count = -1;
  Map<String, dynamic> _params;
  List<Song> _songData = []; // 单曲数据
//  List<Artists> _artistsData = []; // 专辑数据
//  List<Albums> _albumsData = []; // 专辑数据
  List<SongList> _songListData = []; // 歌单数据
  List<User> _userListData = []; // 用户数据
  //List<Videos> _videosData = []; // 视频数据
  EasyRefreshController _controller;
  int offset = 1;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    WidgetsBinding.instance.addPostFrameCallback((d) {
      _params = {
        'name': widget.keywords,
        'page':1
      };
      _request();
    });
  }

  void _request() async {
    if(offset > 1) _params['page'] = offset;
    var songRes = await NetUtils1.searchSong(context, params: _params);
    var songListRes = await NetUtils1.searchSongList(context, params: _params);
    if (mounted) {
      setState(() {
        switch (int.parse(widget.type)) {
          case 1: // 单曲
            _count = songRes.data.length;
            List<Song> list=[];
            songRes.data.forEach((element) { 
              list.add(Song.fromJson(element));
            });
            print(list);
            _songData.addAll(list);
            break;
//          case 10: // 专辑
//            _count = r.result.albumCount;
//            _albumsData.addAll(r.result.albums);
//            break;
//          case 100: // 歌手
//            _count = r.result.artistCount;
//            _artistsData.addAll(r.result.artists);
//            break;
          case 2: // 歌单
            _count = songListRes.data.length;
            List<SongList> list=[];
            songListRes.data.forEach((element) {
              list.add(SongList.fromJson(element));
            });
            _songListData.addAll(list);
            break;
//          case 1002: // 用户
//            _count = r.result.userprofileCount;
//            _userListData.addAll(r.result.userprofiles);
//            break;
//          case 1014: // 视频
//            _count = r.result.videoCount;
//            _videosData.addAll(r.result.videos);
//            break;
          default:
            break;
        }
      });
    }
  }

  // 构建单曲页面
  Widget _buildSongsPage() {
    return Consumer<PlaySongsModel>(
      builder: (context, model, child) {
        return EasyRefresh.custom(
          slivers: [
            SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () {
                  _playSongs(model, _songData, 0);
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.play_circle_outline,
                      color: Colors.black87,
                    ),
                    HEmptyView(10),
                    Text(
                      '播放全部',
                      style: common18TextStyle,
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: VEmptyView(30),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  var song = _songData[index];
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      _playSongs(model, _songData, index);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),

                      child: WidgetMusicListItem(
                        song,
                        index+1,
                        onTap: (){
                          model.playSong(song);
                          NavigatorUtil.goPlaySongsPage(context);
                        },
                      ),
                    ),
                  );
                },
                childCount: _songData.length,
              ),
            )
          ],
          footer: LoadFooter(),
          controller: _controller,
          onLoad: () async {
            _params['page'] = _params['page']+1;
            _request();
            _controller.finishLoad(noMore: _songData.length >= _count);
          },
        );
      },
    );
  }

  void _playSongs(PlaySongsModel model, List<Song> data, int index) {
    model.playSongs(
      data,
      index: index,
    );
    NavigatorUtil.goPlaySongsPage(context);
  }

  // 构建专辑页面
//  Widget _buildAlbumPage() {
//    return _buildLoadMoreWidget<Albums>(_albumsData, (curData) {
//      return AlbumWidget(
//          curData.picUrl, curData.name, '${curData.artist.name}');
//    });
//  }

  // 构建歌手页面
//  Widget _buildArtistsPage() {
//    return _buildLoadMoreWidget<Artists>(_artistsData, (curData) {
//      return ArtistsWidget(
//        picUrl: curData.picUrl.isEmpty ? curData.img1v1Url : curData.picUrl,
//        name: curData.name,
//        accountId: curData.accountId,
//      );
//    });
//  }

  // 构建歌单页面
  Widget _buildPlayListPage() {
    return _buildLoadMoreWidget<SongList>(_songListData, (curData) {
      return SearchPlayListWidget(curData,110);
    });
  }

//  // 构建用户页面
//  Widget _buildUserPage() {
//    return _buildLoadMoreWidget<Users>(_userListData, (curData) {
//      return SearchUserWidget(
//        url: curData.avatarUrl,
//        name: curData.nickname,
//        description: curData.description,
//      );
//    });
//  }
//
//  // 构建专辑页面
//  Widget _buildVideoPage() {
//    return _buildLoadMoreWidget<Videos>(_videosData, (video) {
//      return SearchVideoWidget(
//        url: video.coverUrl,
//        playCount: video.playTime,
//        title: video.title,
//        type: video.type,
//        creatorName: video.creator.map((c) => c.userName).join('/'),
//      );
//    });
//  }

  Widget _buildLoadMoreWidget<T>(
      List<T> data, LoadMoreWidgetBuilder<T> builder) {
    return EasyRefresh.custom(
      slivers: [
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return builder(data[index]);
        }, childCount: data.length))
      ],
      footer: LoadFooter(),
      controller: _controller,
      onLoad: () async {
        offset++;
        _request();
        _controller.finishLoad(noMore: _songData.length >= _count);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_count == -1) {
      return CupertinoActivityIndicator();
    }

    Widget result;

    switch (int.parse(widget.type)) {
      case 1: // 单曲
        result = _buildSongsPage();
        break;
//      case 10: // 专辑
//        result = _buildAlbumPage();
//        break;
//      case 100: // 歌手
//        result = _buildArtistsPage();
//        break;
      case 2: // 歌单
        result = _buildPlayListPage();
        break;
//      case 1002: // 用户
//        result = _buildUserPage();
//        break;
//      case 1014: // 视频
//        result = _buildVideoPage();
//        break;
      default:
        result = Container();
        break;
    }

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(20),
          vertical: ScreenUtil().setWidth(20)),
      child: result,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
