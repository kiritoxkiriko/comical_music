import 'Image.dart';
import 'Singer.dart';

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

  Album.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _singer = json['singer'];
    _year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['image'] = this._image;
    data['singer'] = this._singer;
    data['year'] = this._year;
    return data;
  }
}