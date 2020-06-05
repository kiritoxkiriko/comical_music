import 'package:comical_music/model1/Image.dart';

import 'JsonObject.dart';

class User {
  int _id;
  String _username;
  bool _ban;
  Image _image;

  User({int id, String username, bool ban, Image image}) {
    this._id = id;
    this._username = username;
    this._ban = ban;
    this._image = image;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get username => _username;
  set username(String username) => _username = username;
  bool get ban => _ban;
  set ban(bool ban) => _ban = ban;
  Image get image => _image;
  set image(Image image) => _image = image;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _username = json['username'];
    _ban = json['ban'];
    _image = json['image']!=null? Image.fromJson(json['image']):null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['username'] = this._username;
    data['ban'] = this._ban;
    if(this._image!=null){
      data['image'] = this._image.toJson();
    }
    return data;
  }
}