import 'package:comical_music/application.dart';
import 'package:comical_music/model1/Album.dart';
import 'package:comical_music/model1/Singer.dart';
import 'package:comical_music/model1/Tag.dart';
import 'package:comical_music/model1/User.dart';

import 'JsonObject.dart';

class Song {
  int _id;
  String _name;
  List<Tag> _tags;
  List<Singer> _singers;
  Album _album;
  User _uploader;
  int _uploadTime;
  String _path;
  String _lrcPath;
  bool _exist;

  Song(
      {int id,
        String name,
        List<Tag> tags,
        List<Singer> singers,
        Album album,
        User uploader,
        int uploadTime,
        String path,
        String lrcPath,
        int commentCount,
        bool exist
      }) {
    this._id = id;
    this._name = name;
    this._tags = tags;
    this._singers = singers;
    this._album = album;
    this._uploader = uploader;
    this._uploadTime = uploadTime;
    this._path = path;
    this._exist=exist;
    this._lrcPath=lrcPath;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  List<Tag> get tags => _tags;
  set tags(List<Tag> tags) => _tags = tags;
  List<Singer> get singers => _singers;
  set singers(List<Singer> singers) => _singers = singers;
  Album get album => _album;
  set album(Album album) => _album = album;
  User get uploader => _uploader;
  set uploader(User uploader) => _uploader = uploader;
  int get uploadTime => _uploadTime;
  set uploadTime(int uploadTime) => _uploadTime = uploadTime;
  String get path {
    var token = Application.sp.getString("token");
    if(token!=null||token!=""){
      return _path+"?token="+token;
    }
    return _path;
  }
  set path(String path){
    _path = path;
  }


  String get lrcPath => _lrcPath;

  set lrcPath(String value) {
    _lrcPath = value;
  }

  bool get exist => _exist;

  set exist(bool value) {
    _exist = value;
  }




  Song.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    if (json['tags'] != null) {
      _tags = new List<Tag>();
      json['tags'].forEach((v) {
        _tags.add(new Tag.fromJson(v));
      });
    }
    if (json['singers'] != null) {
      _singers = new List<Singer>();
      json['singers'].forEach((v) {
        _singers.add(new Singer.fromJson(v));
      });
    }
    _album = json['album'] != null ? new Album.fromJson(json['album']) : null;
    _uploader = json['uploader'] != null
        ? new User.fromJson(json['uploader'])
        : null;
    _uploadTime = json['uploadTime'];
    _path = json['path'];
    _lrcPath = json['lrcPath'];
    //_commentCount=json['commentCount'];
    _exist=json['exist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    if (this._tags != null) {
      data['tags'] = this._tags.map((v) => v.toJson()).toList();
    }
    if (this._singers != null) {
      data['singers'] = this._singers.map((v) => v.toJson()).toList();
    }
    if (this._album != null) {
      data['album'] = this._album.toJson();
    }
    if (this._uploader != null) {
      data['uploader'] = this._uploader.toJson();
    }
    data['uploadTime'] = this._uploadTime;
    data['path'] = this._path;
    data['lrcPath'] = this._lrcPath;
    //data['commentCount']=this.commentCount;
    data['exist']=this._exist;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Song && runtimeType == other.runtimeType && _id == other._id;

  @override
  int get hashCode => _id.hashCode;

  @override
  String toString() {
    return 'Song{_id: $_id, _name: $_name, _tags: $_tags, _singers: $_singers, _album: $_album, _uploader: $_uploader, _uploadTime: $_uploadTime, _path: $_path, _lrcPath: $_lrcPath, _exist: $_exist}';
  }
}