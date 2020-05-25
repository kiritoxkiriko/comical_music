import 'package:comical_music/model/event_content.dart';

import 'User.dart';

class SongComment {
  int _id;
  String _content;
  User _replier;
  SongComment _replyTo;
  String _date;
  int _likeCount;
  bool _exist;

  SongComment(
      {int id,
        String content,
        User replier,
        SongComment replyTo,
        String date,
        int likeCount,
        bool exist}) {
    this._id = id;
    this._content = content;
    this._replier = replier;
    this._replyTo = replyTo;
    this._date = date;
    this._likeCount = likeCount;
    this._exist = exist;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get content => _content;
  set content(String content) => _content = content;
  User get replier => _replier;
  set replier(User replier) => _replier = replier;
  SongComment get replyTo => _replyTo;
  set replyTo(SongComment replyTo) => _replyTo = replyTo;
  String get date => _date;
  set date(String date) => _date = date;
  int get likeCount => _likeCount;
  set likeCount(int likeCount) => _likeCount = likeCount;
  bool get exist => _exist;
  set exist(bool exist) => _exist = exist;

  SongComment.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _content = json['content'];
    _replier = json['replier'];
    _replyTo = json['replyTo'];
    _date = json['date'];
    _likeCount = json['likeCount'];
    _exist = json['exist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['content'] = this._content;
    data['replier'] = this._replier;
    data['replyTo'] = this._replyTo;
    data['date'] = this._date;
    data['likeCount'] = this._likeCount;
    data['exist'] = this._exist;
    return data;
  }
}