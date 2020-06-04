
import 'dart:ui';

import 'package:comical_music/model1/Song.dart';
import 'package:comical_music/model1/Tag.dart';

import 'package:comical_music/model1/User.dart';

import 'JsonObject.dart';

class SongList  {
  int _id;
  String _name;
  List<Tag> _tags;
  String _introduction;
  User _creator;
  int _time;
  List<Song> _songs;
  Image _image;
  bool _open;
  bool _exist;

  SongList(
      {int id,
        String name,
        List<Tag> tags,
        String introduction,
        User creator,
        int time,
        List<Song> songs,
        Image image,
        bool open,
        bool exist
      }) {
    this._id = id;
    this._name = name;
    this._tags = tags;
    this._introduction = introduction;
    this._creator = creator;
    this._time = time;
    this._songs = songs;
    this._image = image;
    this._open = open;
    this._exist=exist;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  List<Tag> get tags => _tags;
  set tags(List<Tag> tags) => _tags = tags;
  String get introduction => _introduction;
  set introduction(String introduction) => _introduction = introduction;
  User get creator => _creator;
  set creator(User creator) => _creator = creator;
  int get time => _time;
  set time(int time) => _time = time;
  List<Song> get songs => _songs;
  set songs(List<Song> songs) => _songs = songs;
  Image get image => _image;
  set image(Image image) => _image = image;
  bool get open => _open;
  set open(bool open) => _open = open;


  bool get exist => _exist;

  set exist(bool value) {
    _exist = value;
  }

  SongList.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _tags = json['tags'];
    _introduction = json['introduction'];
    _creator = json['creator'];
    _time = json['time'];
    _songs = json['songs'];
    _image = json['image'];
    _open = json['open'];
    _exist=json['exist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['tags'] = this._tags;
    data['introduction'] = this._introduction;
    data['creator'] = this._creator;
    data['time'] = this._time;
    data['songs'] = this._songs;
    data['image'] = this._image;
    data['open'] = this._open;
    data['exist']=this._exist;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongList && runtimeType == other.runtimeType && _id == other._id;

  @override
  int get hashCode => _id.hashCode;
}