class Image {
  String _path;

  Image({String path}) {
    this._path = path;
  }

  String get path => _path;
  set path(String path) => _path = path;

  Image.fromJson(Map<String, dynamic> json) {
    _path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this._path;
    return data;
  }
}