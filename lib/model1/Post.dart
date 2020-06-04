import 'dart:ui';


import 'package:comical_music/model1/PageResponseData.dart';
import 'package:comical_music/model1/UserSpace.dart';
import 'package:comical_music/utils/net_utils1.dart';
import 'package:loading_more_list/loading_more_list.dart';

import 'package:comical_music/model1/Image.dart';
import 'package:comical_music/model1/Board.dart';
import 'package:comical_music/model1/Song.dart';
import 'package:comical_music/model1/SongList.dart';
import 'package:comical_music/model1/User.dart';

import 'JsonObject.dart';


class PostRepository extends LoadingMoreBase<Post> {
  int pageindex = 1;
  bool _hasMore = true;
  bool forceRefresh = false;
  PageResponseData _eventPage;
  @override
  bool get hasMore => _hasMore;

  @override
  Future<bool> refresh([bool clearBeforeRequest = false]) async {
    _hasMore = true;
    pageindex = 1;
    //force to refresh list when you don't want clear list before request
    //for the case, if your list already has 20 items.
    forceRefresh = !clearBeforeRequest;
    var result = await super.refresh(clearBeforeRequest);
    forceRefresh = false;
    return result;
  }

  @override
  Future<bool> loadData([bool isLoadMoreAction = false]) async {
    int page;
    bool isSuccess = false;
    try {
      if(pageindex == 1){
        this.clear();
      }

      var r = await NetUtils1.getPost(page: pageindex);
      _eventPage = r;
      r.data.forEach((element) {
        this.add(Post.fromJson(element));
      });
      _hasMore = r.hasNext;
      pageindex++;
      isSuccess = true;
    } catch (exception, stack) {
      isSuccess = false;
      print(exception);
      print(stack);
    }
    return isSuccess;
  }
}

class Post {
  int _id;
  int _time;
  String _content;
  List<Song> _sharedSongs;
  List<Image> _sharedImages;
  List<SongList> _sharedSongLists;
  User _poster;
  Board _postedBoard;
  int _likeCount;
  bool _exist;
  int _type;
  int _replyCount;

  Post(
      {int id,
        int time,
        String content,
        List<Song> sharedSongs,
        List<Image> sharedImages,
        List<SongList> sharedSongLists,
        User poster,
        Board postedBoard,
        int likeCount,
        bool exist,
        int type,
        int replyCount}) {
    this._id = id;
    this._time = time;
    this._content = content;
    this._sharedSongs = sharedSongs;
    this._sharedImages = sharedImages;
    this._sharedSongLists = sharedSongLists;
    this._poster = poster;
    this._postedBoard = postedBoard;
    this._likeCount = likeCount;
    this._exist = exist;
    this._type=type;
    this._replyCount=replyCount;
  }

  int get id => _id;
  set id(int id) => _id = id;
  int get time => _time;
  set time(int time) => _time = time;
  String get content => _content;
  set content(String content) => _content = content;
  List<Song> get sharedSongs => _sharedSongs;
  set sharedSongs(List<Song> sharedSongs) => _sharedSongs = sharedSongs;
  List<Image> get sharedImages => _sharedImages;
  set sharedImages(List<Image> sharedImages) => _sharedImages = sharedImages;
  List<SongList> get sharedSongLists => _sharedSongLists;
  set sharedSongLists(List<SongList> sharedSongLists) =>
      _sharedSongLists = sharedSongLists;
  User get poster => _poster;
  set poster(User poster) => _poster = poster;
  Board get postedBoard => _postedBoard;
  set postedBoard(Board postedBoard) => _postedBoard = postedBoard;
  int get likeCount => _likeCount;
  set likeCount(int likeCount) => _likeCount = likeCount;
  bool get exist => _exist;
  set exist(bool exist) => _exist = exist;
  int get replyCount => _replyCount;

  set replyCount(int value) {
    _replyCount = value;
  }

  int get type => _type;

  set type(int value) {
    _type = value;
  }

  Post.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _time = json['time'];
    _content = json['content'];
    if (json['sharedSongs'] != null) {
      _sharedSongs = new List<Song>();
      json['sharedSongs'].forEach((v) {
        _sharedSongs.add(new Song.fromJson(v));
      });
    }
    if (json['sharedImages'] != null) {
      _sharedImages = new List<Image>();
      json['sharedImages'].forEach((v) {
        _sharedImages.add(new Image.fromJson(v));
      });
    }
    if (json['sharedSongLists'] != null) {
      _sharedSongLists = new List<SongList>();
      json['sharedSongLists'].forEach((v) {
        _sharedSongLists.add(new SongList.fromJson(v));
      });
    }
    _poster =
    json['poster'] != null ? new User.fromJson(json['poster']) : null;
    _postedBoard = json['postedBoard'] != null
        ? new Board.fromJson(json['postedBoard'])
        : null;
    _likeCount = json['likeCount'];
    _exist = json['exist'];
    _type = json['type'];
    _replyCount = json['replyCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['time'] = this._time;
    data['content'] = this._content;
    data['sharedSongs'] = this._sharedSongs.map((v) => v.toJson()).toList();
    data['sharedImages'] = this._sharedImages.map((v) => v.toJson()).toList();
    if (this._sharedSongLists != null) {
      data['sharedSongLists'] =
          this._sharedSongLists.map((v) => v.toJson()).toList();
    }
    if (this._poster != null) {
      data['poster'] = this._poster.toJson();
    }
    if (this._postedBoard != null) {
      data['postedBoard'] = this._postedBoard.toJson();
    }
    data['likeCount'] = this._likeCount;
    data['exist'] = this._exist;
    data['type'] = this._type;
    data['replyCount'] = this._replyCount;
    return data;
  }
}
