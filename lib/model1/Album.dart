import 'package:comical_music/model1/Image.dart';
import 'package:comical_music/model1/JsonObject.dart';
import 'package:comical_music/model1/Singer.dart';

class Album {
  int _id;
  String _name;
  Image _image;
  Singer _singer;
  int _year;

  Album({int id, String name, Image image, Singer singer, int year}) {
    this._id = id;
    this._name = name;
    this._image = image;
    this._singer = singer;
    this._year = year;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  Image get image => _image;
  set image(Image image) => _image = image;
  Singer get singer => _singer;
  set singer(Singer singer) => _singer = singer;
  int get year => _year;
  set year(int year) => _year = year;

  @override
  Album.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    _singer =
    json['singer'] != null ? new Singer.fromJson(json['singer']) : null;
    _year = json['year'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    if (this._image != null) {
      data['image'] = this._image.toJson();
    }
    if (this._singer != null) {
      data['singer'] = this._singer.toJson();
    }
    data['year'] = this._year;
    return data;
  }
}
