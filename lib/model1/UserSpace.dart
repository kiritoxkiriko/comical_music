import 'SongList.dart';

class UserSpace {
  int _id;
  String _information;
  SongList _favoriteSongs;
  List<SongList> _favoriteSongLists;

  UserSpace(
      {int id,
        String information,
        SongList favoriteSongs,
        List<SongList> favoriteSongLists}) {
    this._id = id;
    this._information = information;
    this._favoriteSongs = favoriteSongs;
    this._favoriteSongLists = favoriteSongLists;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get information => _information;
  set information(String information) => _information = information;
  SongList get favoriteSongs => _favoriteSongs;
  set favoriteSongs(SongList favoriteSongs) => _favoriteSongs = favoriteSongs;
  List<SongList> get favoriteSongLists => _favoriteSongLists;
  set favoriteSongLists(List<SongList> favoriteSongLists) =>
      _favoriteSongLists = favoriteSongLists;

  UserSpace.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _information = json['information'];
    _favoriteSongs = json['favoriteSongs'];
    _favoriteSongLists = json['favoriteSongLists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['information'] = this._information;
    data['favoriteSongs'] = this._favoriteSongs;
    data['favoriteSongLists'] = this._favoriteSongLists;
    return data;
  }
}