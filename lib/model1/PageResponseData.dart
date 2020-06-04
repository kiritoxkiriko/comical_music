import 'package:comical_music/model1/ResponseData.dart';
class PageResponseData extends ResponseData{
  List<dynamic> _data;
  int _size;
  int _total;
  int _num;
  int _totalElements;
  bool _hasNext;

  PageResponseData(
      {int code,
        String msg,
        List<dynamic> data,
        int size,
        int total,
        int num,
        int totalElements,
        bool hasNext}) {
    super.code = code;
    super.msg = msg;
    this._data = data;
    this._size = size;
    this._total = total;
    this._num = num;
    this._totalElements=totalElements;
    this._hasNext = hasNext;
  }

  @override
  List<dynamic> get data => _data;
  @override
  set data(dynamic data) {
    _data = data;
  }
  int get size => _size;
  set size(int size) => _size = size;
  int get total => _total;
  set total(int total) => _total = total;
  int get num => _num;
  set num(int num) => _num = num;
  bool get hasNext => _hasNext;
  set hasNext(bool hasNext) => _hasNext = hasNext;


  int get totalElements => _totalElements;

  set totalElements(int value) {
    _totalElements = value;
  }

  PageResponseData.fromJson(Map<String, dynamic> json) {
    super.code = json['code'];
    super.msg = json['msg'];
    if (json['data'] != null) {
      _data = new List<dynamic>();
      json['data'].forEach((v) {
        _data.add(v);
      });
    }
    _size = json['size'];
    _total = json['total'];
    _num = json['num'];
    _hasNext = json['hasNext'];
    _totalElements = json['totalElements'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = super.code;
    data['msg'] = super.msg;
    if (_data != null) {
      data['data'] = this._data.map((v) => v.toJson()).toList();
    }
    data['size'] = this._size;
    data['total'] = this._total;
    data['num'] = this._num;
    data['hasNext'] = this._hasNext;
    data['totalElements'] = this._totalElements;
    return data;
  }
}