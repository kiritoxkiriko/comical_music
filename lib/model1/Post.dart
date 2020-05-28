import 'User.dart';

class Reply {
  int _id;
  String _content;
  User _replier;
  Reply _replyTo;
  int _date;
  int _likeCount;
  bool _exist;

  Reply(
      {int id,
        String content,
        User replier,
        Reply replyTo,
        int date,
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
  Reply get replyTo => _replyTo;
  set replyTo(Reply replyTo) => _replyTo = replyTo;
  int get date => _date;
  set date(int date) => _date = date;
  int get likeCount => _likeCount;
  set likeCount(int likeCount) => _likeCount = likeCount;
  bool get exist => _exist;
  set exist(bool exist) => _exist = exist;

  Reply.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _content = json['content'];
    _replier =
    json['replier'] != null ? new User.fromJson(json['replier']) : null;
    _replyTo =
    json['replyTo'] != null ? new Reply.fromJson(json['replyTo']) : null;
    _date = json['date'];
    _likeCount = json['likeCount'];
    _exist = json['exist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['content'] = this._content;
    if (this._replier != null) {
      data['replier'] = this._replier.toJson();
    }
    if (this._replyTo != null) {
      data['replyTo'] = this._replyTo.toJson();
    }
    data['date'] = this._date;
    data['likeCount'] = this._likeCount;
    data['exist'] = this._exist;
    return data;
  }
}