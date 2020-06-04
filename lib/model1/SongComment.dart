import 'package:comical_music/model/event_content.dart';

import 'JsonObject.dart';
import 'User.dart';

class SongComment {
  int _id;
  String _content;
  User _replier;
  SongComment _replyTo;
  int _time;
  int _likeCount;
  bool _exist;

  SongComment(
      {int id,
        String content,
        User replier,
        SongComment replyTo,
        int time,
        int likeCount,
        bool exist}) {
    this._id = id;
    this._content = content;
    this._replier = replier;
    this._replyTo = replyTo;
    this._time = time;
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
  int get time => _time;
  set time(int time) => _time = time;
  int get likeCount => _likeCount;
  set likeCount(int likeCount) => _likeCount = likeCount;
  bool get exist => _exist;
  set exist(bool exist) => _exist = exist;

  SongComment.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _content = json['content'];
    if(json['replier']!=null) {
      _replier = User.fromJson(json['replier']);
    }
    if(json['replyTo']!=null){
      _replyTo = SongComment.fromJson(json['replyTo']);
    }
    _time = json['time'];
    _likeCount = json['likeCount'];
    _exist = json['exist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['content'] = this._content;
    data['replier'] = this._replier;
    data['replyTo'] = this._replyTo;
    data['time'] = this._time;
    data['likeCount'] = this._likeCount;
    data['exist'] = this._exist;
    return data;
  }
}