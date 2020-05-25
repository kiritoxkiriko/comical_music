

import 'dart:ui';

import 'Board.dart';
import 'Song.dart';
import 'SongList.dart';
import 'User.dart';

class Post {
  int _id;
  String _date;
  String _content;
  List<Song> _sharedSongs;
  List<Image> _sharedImages;
  List<SongList> _sharedSongLists;
  User _poster;
  Board _postedBoard;
  int _likeCount;
  bool _exist;

  Post(
      {int id,
        String date,
        String content,
        List<Song> sharedSongs,
        List<Image> sharedImages,
        List<SongList> sharedSongLists,
        User poster,
        Board postedBoard,
        int likeCount,
        bool exist}) {
    this._id = id;
    this._date = date;
    this._content = content;
    this._sharedSongs = sharedSongs;
    this._sharedImages = sharedImages;
    this._sharedSongLists = sharedSongLists;
    this._poster = poster;
    this._postedBoard = postedBoard;
    this._likeCount = likeCount;
    this._exist = exist;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get date => _date;
  set date(String date) => _date = date;
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

  Post.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _date = json['date'];
    _content = json['content'];
    _sharedSongs = json['sharedSongs'];
    _sharedImages = json['sharedImages'];
    _sharedSongLists = json['sharedSongLists'];
    _poster = json['poster'];
    _postedBoard = json['postedBoard'];
    _likeCount = json['likeCount'];
    _exist = json['exist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['date'] = this._date;
    data['content'] = this._content;
    data['sharedSongs'] = this._sharedSongs;
    data['sharedImages'] = this._sharedImages;
    data['sharedSongLists'] = this._sharedSongLists;
    data['poster'] = this._poster;
    data['postedBoard'] = this._postedBoard;
    data['likeCount'] = this._likeCount;
    data['exist'] = this._exist;
    return data;
  }
}