
import 'dart:ui';

import 'Song.dart';
import 'Tag.dart';

import 'User.dart';

class SongList {
  int _id;
  String _name;
  List<Tag> _tags;
  String _introduction;
  User _creator;
  String _date;
  List<Song> _songs;
  Image _image;
  bool _open;

  SongList(
      {int id,
        String name,
        List<Tag> tags,
        String introduction,
        User creator,
        String date,
        List<Song> songs,
        Image image,
        bool open}) {
    this._id = id;
    this._name = name;
    this._tags = tags;
    this._introduction = introduction;
    this._creator = creator;
    this._date = date;
    this._songs = songs;
    this._image = image;
    this._open = open;
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
  String get date => _date;
  set date(String date) => _date = date;
  List<Song> get songs => _songs;
  set songs(List<Song> songs) => _songs = songs;
  Image get image => _image;
  set image(Image image) => _image = image;
  bool get open => _open;
  set open(bool open) => _open = open;

  SongList.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _tags = json['tags'];
    _introduction = json['introduction'];
    _creator = json['creator'];
    _date = json['date'];
    _songs = json['songs'];
    _image = json['image'];
    _open = json['open'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['tags'] = this._tags;
    data['introduction'] = this._introduction;
    data['creator'] = this._creator;
    data['date'] = this._date;
    data['songs'] = this._songs;
    data['image'] = this._image;
    data['open'] = this._open;
    return data;
  }
}