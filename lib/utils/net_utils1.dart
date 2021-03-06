import 'dart:async';
import 'dart:io';

import 'package:comical_music/model1/Board.dart';
import 'package:comical_music/model1/PageResponseData.dart';
import 'package:comical_music/model1/Reply.dart';
import 'package:comical_music/model1/ResponseData.dart';
import 'package:comical_music/model1/Song.dart';
import 'package:comical_music/model1/SongComment.dart';
import 'package:comical_music/model1/SongList.dart';
import 'package:comical_music/model1/UserSpace.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:comical_music/model/album.dart';
import 'package:comical_music/model/banner.dart' as mBanner;
import 'package:comical_music/model/daily_songs.dart';
import 'package:comical_music/model/hot_search.dart';
import 'package:comical_music/model/lyric.dart';
import 'package:comical_music/model/mv.dart';
import 'package:comical_music/model/play_list.dart';
import 'package:comical_music/model/recommend.dart';
import 'package:comical_music/model/search_result.dart' hide User,Song;
import 'package:comical_music/model/song_comment.dart' hide User;
import 'package:comical_music/model/song_detail.dart';
import 'package:comical_music/model/top_list.dart';
import 'package:comical_music/model1/User.dart';
import 'package:comical_music/model/user_detail.dart';
import 'package:comical_music/route/navigate_service.dart';
import 'package:comical_music/route/routes.dart';
import 'package:comical_music/utils/utils.dart';
import 'package:comical_music/widgets/loading.dart';
import 'package:path_provider/path_provider.dart';

import "dart:math";

import '../application.dart';
import 'custom_log_interceptor.dart';

class NetUtils1 {
  static Dio _dio;
  static Dio _dioURL;
  static String token=Application.sp.getString("token");
  static final String baseUrl = 'http://192.168.1.124:8088/api';
  static Future<List<InternetAddress>> _fm10s =
  InternetAddress.lookup("ws.acgvideo.com");

  static void updateToken(){
    token=Application.sp.getString("token");
  }

  static void init() async {

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    CookieJar cj = PersistCookieJar(dir: tempPath);
    _dio = Dio(BaseOptions(baseUrl: baseUrl, followRedirects: false))
      ..interceptors.add(CookieManager(cj))
      ..interceptors
          .add(LogInterceptor(responseBody: true, requestBody: true));
    _dioURL = Dio()
      ..interceptors
          .add(LogInterceptor(responseBody: true, requestBody: true));

    // 海外華人可使用 nondanee/UnblockNeteaseMusic
//    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//        (client) {
//      client.findProxy = (uri) {
//        var host = uri.host;
//        if (host == 'music.163.com' ||
//            host == 'interface.music.163.com' ||
//            host == 'interface3.music.163.com' ||
//            host == 'apm.music.163.com' ||
//            host == 'apm3.music.163.com' ||
//            host == '59.111.181.60' ||
//            host == '223.252.199.66' ||
//            host == '223.252.199.67' ||
//            host == '59.111.160.195' ||
//            host == '59.111.160.197' ||
//            host == '59.111.181.38' ||
//            host == '193.112.159.225' ||
//            host == '118.24.63.156' ||
//            host == '59.111.181.35' ||
//            host == '39.105.63.80' ||
//            host == '47.100.127.239' ||
//            host == '103.126.92.133' ||
//            host == '103.126.92.132') {
//          return 'PROXY YOURPROXY;DIRECT';
//        }
//        return 'DIRECT';
//      };
//    };
  }

  static Future<Response> _get(
      BuildContext context,
      String url, {
        Map<String, dynamic> params,
        bool isShowLoading = true,
      }) async {
    Options options=Options(headers: {HttpHeaders.authorizationHeader:token});
    if (isShowLoading) Loading.showLoading(context);
    try {
      print(params);
      assert(_dio!=null);
      return await _dio.get(url,queryParameters: params, options: options);
    } on DioError catch (e) {
      print('1');
      if (e == null) {
        print('2');
        return Future.error(Response(data: -1));
      } else if (e.response != null) {
        if (e.response.statusCode !=200) {
          _reLogin();
          print('3');
          return Future.error(Response(data: -1));
        } else {
          print('4');
          return Future.value(e.response);
        }
      } else {
        print('5');
        return Future.error(Response(data: -1));
      }
    } finally {
      Loading.hideLoading(context);
    }
  }

  static Future<Response> _getURL(
      BuildContext context,
      String url, {
        Map<String, dynamic> params,
        bool isShowLoading = true,
      }) async {
    Options options=Options(headers: {HttpHeaders.authorizationHeader:token});
    if (isShowLoading) Loading.showLoading(context);
    try {
      print(params);
      assert(_dioURL!=null);
      return await _dioURL.get(url,queryParameters: params, options: options);
    } on DioError catch (e) {
      print('1');
      if (e == null) {
        print('2');
        return Future.error(Response(data: -1));
      } else if (e.response != null) {
        if (e.response.statusCode !=200) {
          _reLogin();
          print('3');
          return Future.error(Response(data: -1));
        } else {
          print('4');
          return Future.value(e.response);
        }
      } else {
        print('5');
        return Future.error(Response(data: -1));
      }
    } finally {
      Loading.hideLoading(context);
    }
  }

  static Future<Response> _post(
      BuildContext context,
      String url, {
        Map<String, dynamic> params,
        bool isShowLoading = true,
      }) async {
    Options options=Options(headers: {HttpHeaders.authorizationHeader:token});
    if (isShowLoading) Loading.showLoading(context);
    try {
      print(params);
      assert(_dio!=null);
      return await _dio.post(url,queryParameters: params, options: options);
    } on DioError catch (e) {
      print('1');
      if (e == null) {
        print('2');
        return Future.error(Response(data: -1));
      } else if (e.response != null) {
        if (e.response.statusCode !=200) {
          _reLogin();
          print('3');
          return Future.error(Response(data: -1));
        } else {
          print('4');
          return Future.value(e.response);
        }
      } else {
        print('5');
        return Future.error(Response(data: -1));
      }
    } finally {
      Loading.hideLoading(context);
    }
  }

  static Future<Response> _delete(
      BuildContext context,
      String url, {
        Map<String, dynamic> params,
        bool isShowLoading = true,
      }) async {
    Options options=Options(headers: {HttpHeaders.authorizationHeader:token});
    if (isShowLoading) Loading.showLoading(context);
    try {
      print(params);
      assert(_dio!=null);
      return await _dio.delete(url,queryParameters: params, options: options);
    } on DioError catch (e) {
      print('1');
      if (e == null) {
        print('2');
        return Future.error(Response(data: -1));
      } else if (e.response != null) {
        if (e.response.statusCode !=200) {
          _reLogin();
          print('3');
          return Future.error(Response(data: -1));
        } else {
          print('4');
          return Future.value(e.response);
        }
      } else {
        print('5');
        return Future.error(Response(data: -1));
      }
    } finally {
      Loading.hideLoading(context);
    }
  }

  static void _reLogin() {
    Future.delayed(Duration(milliseconds: 200), () {
      Application.getIt<NavigateService>().popAndPushNamed(Routes.login);
      Utils.showToast('登录失效，请重新登录');
    });
  }

  /// 登录
  static Future<ResponseData> login(
      BuildContext context, String phone, String password) async {
    var response = await _post(context, '/login', params: {
      'phone': phone,
      'password': password,
    });

    return ResponseData.fromJson(response.data);
  }
  static Future<ResponseData> quickLogin(
      BuildContext context, String phone, String code) async {
    var response = await _post(context, '/quickLogin', params: {
      'phone': phone,
      'code': code,
    });

    return ResponseData.fromJson(response.data);
  }

  static Future<ResponseData> getPhoneCode(BuildContext context, String phone) async{
    var response = await _post(context, '/sendCode', params: {
      'phone': phone,
    });

    return ResponseData.fromJson(response.data);
  }


  static Future<User> getUserInfo(
      BuildContext context) async {
    var response = await _get(context, '/user');
    return User.fromJson(ResponseData.fromJson(response.data).data);
  }

  static Future<Response> refreshLogin(BuildContext context) async {
    return await _get(context, '/login/refresh', isShowLoading: false)
        .catchError((e) {
      Utils.showToast('网络错误！');
    });
  }

  /// 首页 Banner
  static Future<mBanner.Banner> getBannerData(BuildContext context) async {
    var response = await _get(context, '/banner', params: {'type': 1});
    return mBanner.Banner.fromJson(response.data);
  }

  /// 推荐歌单
  static Future<RecommendData> getRecommendData(BuildContext context) async {
    var response = await _get(context, '/recommend/resource');
    return RecommendData.fromJson(response.data);
  }

  /// 推荐歌曲
  static Future<List<Song>> getRecommendSong(BuildContext context) async {
    var response = await _get(context, '/recommend/song');
    List<Song> list=[];
    ResponseData.fromJson(response.data).data.forEach((e){
      list.add(Song.fromJson(e));
    });
    return list;
  }

  /// 新碟上架
  static Future<AlbumData> getAlbumData(
      BuildContext context, {
        Map<String, dynamic> params = const {
          'offset': 1,
          'limit': 10,
        },
      }) async {
    var response = await _get(context, '/top/album', params: params);
    return AlbumData.fromJson(response.data);
  }

  /// MV 排行
  static Future<MVData> getTopMvData(
      BuildContext context, {
        Map<String, dynamic> params = const {
          'offset': 1,
          'limit': 10,
        },
      }) async {
    var response = await _get(context, '/top/mv', params: params);
    return MVData.fromJson(response.data);
  }

  /// 每日推荐歌曲
  static Future<DailySongsData> getDailySongsData(BuildContext context) async {
    var response = await _get(
      context,
      '/recommend/songs',
    );
    return DailySongsData.fromJson(response.data);
  }

  /// 歌单详情
  static Future<PlayListData> getPlayListData(
      BuildContext context, {
        Map<String, dynamic> params,
      }) async {
    var response = await _get(context, '/playlist/detail', params: params);
    return PlayListData.fromJson(response.data);
  }

  /// 歌曲详情
  static Future<SongDetailData> getSongsDetailData(
      BuildContext context, {
        Map<String, dynamic> params,
      }) async {
    var response = await _get(context, '/song/detail', params: params);
    return SongDetailData.fromJson(response.data);
  }

  /// 获取歌曲
  static Future<Song> getSong(BuildContext context, int songId) async{
    var response = await _get(context, '/song/${songId.toString()}');
    return Song.fromJson(ResponseData.fromJson(response.data).data);
  }

  static Future<SongList> getSongList(BuildContext context, {
    @required Map<String, dynamic> params,
  }) async{
    var response = await _get(context, '/songList/${params['songListId'].toString()}');
    return SongList.fromJson(ResponseData.fromJson(response.data).data);
  }

  /// ** 验证发现原来的歌单详情接口就有数据，不用请求两次！！ **
  /// 真正的歌单详情
  /// 因为歌单详情只能获取歌单信息，并不能获取到歌曲信息，所以要请求两个接口，先获取歌单详情，再获取歌曲详情

  static Future<SongDetailData> _getPlayListData(
      BuildContext context, {
        Map<String, dynamic> params,
      }) async {
    var r = await getPlayListData(context, params: params);
    var response = await getSongsDetailData(context, params: {
      'ids': r.playlist.trackIds.map((t) => t.id).toList().join(',')
    });
    response.playlist = r.playlist;
    return response;
  }

  /// 排行榜首页
  static Future<TopListData> getTopListData(BuildContext context) async {
    var response = await _get(context, '/toplist/detail');
    return TopListData.fromJson(response.data);
  }

  /// 获取评论列表
  static Future<PageResponseData> getSongComment(
      BuildContext context, {
        @required Map<String, dynamic> params,
      }) async {
    var response = await _get(context, '/songComment/song/${params['songId']}', isShowLoading: true);
    return PageResponseData.fromJson(response.data);
  }

  /// 获取回复列表
  static Future<PageResponseData> getReply(
      BuildContext context, {
        @required Map<String, dynamic> params,
      }) async {
    var response = await _get(context, '/reply/post/${params['postId']}', isShowLoading: true);
    return PageResponseData.fromJson(response.data);
  }

  /// 获取评论列表
  static Future<SongCommentData> getCommentData(
      BuildContext context,
      int type, {
        @required Map<String, dynamic> params,
      }) async {
    var funcName;
    switch (type) {
      case 0: // song
        funcName = 'music';
        break;
      case 1: // mv
        funcName = 'mv';
        break;
      case 2: // 歌单
        funcName = 'playlist';
        break;
      case 3: // 专辑
        funcName = 'album';
        break;
      case 4: // 电台
        funcName = 'dj';
        break;
      case 5: // 视频
        funcName = 'video';
        break;
    // 动态评论需要threadId，后续再做
    }
    var response = await _get(context, '/comment/$funcName',
        params: params, isShowLoading: false);
    return SongCommentData.fromJson(response.data);
  }

  /// 获取评论列表
  static Future<SongCommentData> sendComment (
      BuildContext context, {
        @required Map<String, dynamic> params,
      }) async {
    var response =
    await _get(context, '/comment', params: params, isShowLoading: true);
    return SongCommentData.fromJson(response.data);
  }

  /// 发送评论
  static Future<SongComment> sendSongComment (
      BuildContext context, {
        @required Map<String, dynamic> params,
      }) async {
    var response =
    await _post(context, '/songComment', params: params, isShowLoading: true);
    return SongComment.fromJson(ResponseData.fromJson(response.data).data);
  }

  /// 回复
  static Future<Reply> sendReply (
      BuildContext context, {
        @required Map<String, dynamic> params,
      }) async {
    var response =
    await _post(context, '/reply', params: params, isShowLoading: true);
    return Reply.fromJson(ResponseData.fromJson(response.data).data);
  }



  /// 获取歌词
  static Future<String> getLyricData(
      BuildContext context, {
        @required String url
      }) async {
    var response =
    await _getURL(context, url, isShowLoading: false);
    return response.data;
  }

  /// 获取个人歌单
  static Future<MyPlayListData> getSelfPlaylistData(
      BuildContext context, {
        @required Map<String, dynamic> params,
      }) async {
    var response = await _get(context, '/user/playlist',
        params: params, isShowLoading: false);
    return MyPlayListData.fromJson(response.data);
  }

  /// 创建歌单
  static Future<PlayListData> createPlaylist(
      BuildContext context, {
        @required Map<String, dynamic> params,
      }) async {
    var response = await _get(context, '/playlist/create',
        params: params, isShowLoading: true);
    return PlayListData.fromJson(response.data);
  }

  /// 创建歌单
  static Future<PlayListData> deletePlaylist(
      BuildContext context, {
        @required Map<String, dynamic> params,
      }) async {
    var response = await _get(context, '/playlist/delete',
        params: params, isShowLoading: true);
    return PlayListData.fromJson(response.data);
  }

  /// 获取热门搜索数据
  static Future<HotSearchData> getHotSearchData(BuildContext context) async {
    var response =
    await _get(context, '/search/hot/detail', isShowLoading: false);
    return HotSearchData.fromJson(response.data);
  }

  /// 综合搜索
  static Future<SearchMultipleData> searchMultiple(
      BuildContext context, {
        @required Map<String, dynamic> params,
      }) async {
    var response = await _get(context, '/search',
        params: params, isShowLoading: false);
    return SearchMultipleData.fromJson(response.data);
  }

  /// 搜索歌曲
  static Future<PageResponseData> searchSong(
      BuildContext context, {
        @required Map<String, dynamic> params,
      }) async {
    var response = await _get(context, '/search/song',
        params: params, isShowLoading: false);
    return PageResponseData.fromJson(response.data);
  }
  /// 搜索歌单
  static Future<PageResponseData> searchSongList(
      BuildContext context, {
        @required Map<String, dynamic> params,
      }) async {
    var response = await _get(context, '/search/songList',
        params: params, isShowLoading: false);
    return PageResponseData.fromJson(response.data);
  }

  /// 获取动态数据
  static Future<PageResponseData> getPost({
    @required int page,
    int boardId
  }) async {
    var response;
    if(boardId==null){
      response = await _get(null, '/post/all',
          params: {'page': page} ,isShowLoading: false);
    }else{
      response = await _get(null, '/post/board/${boardId}',
          params: {'page': page}, isShowLoading: false);
    }

    return PageResponseData.fromJson(response.data);
  }


  /// Music
  static Future<String> getMusicURL(BuildContext context, id) async {
    var m10s = await _fm10s;
    final _random = new Random();
    var m10 = m10s[_random.nextInt(m10s.length)].address;

    var response =
    await _get(context, '/song/url?id=$id', isShowLoading: context != null);
    return response.data['data'][0]["url"]
        .replaceFirst('m10.music.126.net', m10 + '/m10.music.126.net');
  }

//  /// 获取用户信息
//  static Future<UserDetailData> getUserInfo(
//      BuildContext context,{
//        @required Map<String, dynamic> params,
//      }) async {
//    var response = await _get(null, '/user/detail',
//        params: params, isShowLoading: false);
//    return UserDetailData.fromJson(response.data);
//  }

  /// 获取用户信息
  static Future<UserSpace> getUserSpace(
      BuildContext context,{
        @required Map<String, dynamic> params,
      }) async {
    var response = await _get(null, '/user/userSpace',
        params: params, isShowLoading: false);
    return UserSpace.fromJson(ResponseData.fromJson(response.data).data);
  }
  /// 获取用户创建的歌单
  static Future<List<SongList>> getUserCreatedSongList(
      BuildContext context,{
        @required Map<String, dynamic> params,
      }) async {
    var response = await _get(null, '/songList/mySongList',
        params: params, isShowLoading: false);
    List<SongList> list1=[];
    var list2=ResponseData.fromJson(response.data).data;
    list2.forEach((e){
      list1.add(SongList.fromJson(e));
    });
    return list1;
  }

  static Future<List<Board>> getBoard(
      BuildContext context,) async {
    var response = await _get(null, '/board/all',
         isShowLoading: false);
    var data=ResponseData.fromJson(response.data);
    List<Board> boards=[];
    var list=data.data.toList();
    list.forEach((e){
      boards.add(Board.fromJson(e));
    });
    return boards;
  }


  static Future<bool> deleteFavroteSongList (BuildContext context,int songListId) async{
    var res=await _delete(context, "/songList/${songListId}");
    return ResponseData.fromJson(res.data).data;
  }

}

