import 'JsonObject.dart';

class Tag {
  int _id;
  String _name;
  String _type;

  Tag({int id, String name, String type}) {
    this._id = id;
    this._name = name;
    this._type = type;
  }

  int get id => _id;

  set id(int id) => _id = id;

  String get name => _name;

  set name(String name) => _name = name;

  String get type => _type;

  set type(String type) => _type = type;

  Tag.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['type'] = this._type;
    return data;
  }

  @override
  String toString() {
    return 'Tag{_name: $_name}';
  }
}

class Tags {
  static final List<String> language = [
    "华语",
    "粤语",
    "欧美",
    "日语",
    "韩语",
  ];

  static final List<String> genre = [
    "流行",
    "古典",
    "摇滚",
    "民族",
    "电子",
    "舞曲",
    "说唱",
    "轻音乐",
    "爵士",
    "乡村",
    "R&B",
  ];
  static final List<String> theme = [
    "ACG",
    "影视原声",
    "校园",
    "游戏",
    "网络歌曲",
    "钢琴",
    "器乐",
  ];
  static final List<String> scene = [
    "学习",
    "工作",
    "休息",
    "通勤",
  ];
}
