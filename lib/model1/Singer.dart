import 'package:comical_music/model1/Image.dart';

class Singer {
  int _id;
  String _name;
  String _introduction;
  Image _image;

  Singer({int id, String name, String introduction, Image image}) {
    this._id = id;
    this._name = name;
    this._introduction = introduction;
    this._image = image;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get introduction => _introduction;
  set introduction(String introduction) => _introduction = introduction;
  Image get image => _image;
  set image(Image image) => _image = image;

  Singer.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _introduction = json['introduction'];
    _image = json['image'] != null ? new Image.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['introduction'] = this._introduction;
    if (this._image != null) {
      data['image'] = this._image.toJson();
    }
    return data;
  }
}