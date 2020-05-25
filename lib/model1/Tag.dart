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
}