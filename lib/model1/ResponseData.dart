class ResponseData {
  int _code;
  String _msg;
  dynamic _data;

  ResponseData({int code, String msg, dynamic data}) {
    this._code = code;
    this._msg = msg;
    this._data = data;
  }

  int get code => _code;
  set code(int code) => _code = code;
  String get msg => _msg;
  set msg(String msg) => _msg = msg;
  dynamic get data => _data;
  set data(dynamic data) => _data = data;

  ResponseData.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['msg'] = this._msg;
    if (this._data != null) {
      data['data'] = this._data.toJson();
    }
    return data;
  }
}

