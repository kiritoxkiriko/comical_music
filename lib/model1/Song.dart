import 'Album.dart';
import 'Singer.dart';
import 'Tag.dart';
import 'User.dart';

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

  Song(
      {int id,
        String name,
        List<Tag> tags,
        List<Singer> singers,
        Album album,
        User uploader,
        int uploadTime,
        String path,
        String lrcPath}) {
    this._id = id;
    this._name = name;
    this._tags = tags;
    this._singers = singers;
    this._album = album;
    this._uploader = uploader;
    this._uploadTime = uploadTime;
    this._path = path;
    this._lrcPath = lrcPath;
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
  String get path => _path;
  set path(String path) => _path = path;
  String get lrcPath => _lrcPath;
  set lrcPath(String lrcPath) => _lrcPath = lrcPath;

  Song.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _tags = json['tags'];
    _singers = json['singers'];
    _album = json['album'];
    _uploader = json['uploader'];
    _uploadTime = json['uploadTime'];
    _path = json['path'];
    _lrcPath = json['lrcPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['tags'] = this._tags;
    data['singers'] = this._singers;
    data['album'] = this._album;
    data['uploader'] = this._uploader;
    data['uploadTime'] = this._uploadTime;
    data['path'] = this._path;
    data['lrcPath'] = this._lrcPath;
    return data;
  }
}