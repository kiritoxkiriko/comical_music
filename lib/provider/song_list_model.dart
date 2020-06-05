import 'package:comical_music/model/event.dart';
import 'package:comical_music/model/user.dart';
import 'package:comical_music/model1/SongList.dart';
import 'package:comical_music/model1/UserSpace.dart';
import 'package:comical_music/utils/net_utils1.dart';
import 'package:flutter/material.dart';
import 'package:comical_music/model/play_list.dart';
//import 'package:comical_music/model1/User.dart';
import 'package:comical_music/utils/net_utils.dart';

class SongListModel with ChangeNotifier {
  //User user;

  List<SongList> _selfCreateSongList = []; // 我创建的歌单
  List<SongList> _collectSongList = []; // 收藏的歌单
  //Set<SongList> _allSongList = {}; // 所有的歌单
  SongList _myFavoriteSong;

  List<SongList> get selfCreateSongList => _selfCreateSongList;

  List<SongList> get collectSongList => _collectSongList;

  //Set<SongList> get allSongList => _allSongList;


  SongList get myFavoriteSong => _myFavoriteSong;


//  void _splitSongList() {
//    _selfCreateSongList =
//        _allSongList.where((p) => p.creator.userId == user.account.id).toList();
//    _collectSongList =
//        _allSongList.where((p) => p.creator.userId != user.account.id).toList();
//    notifyListeners();
//  }
//
//  void addSongList(SongList SongList){
//    _allSongList.add(SongList);
//    _splitSongList();
//  }

//  void delSongList(SongList SongList) {
//    _allSongList.remove(SongList);
//    _splitSongList();
//  }
  void resetSongList(){
    _selfCreateSongList=[];
    _collectSongList=[];
    _myFavoriteSong=null;
  }

  bool isMine(SongList songList){
    return _selfCreateSongList.contains(songList);
  }

  void deleteSongList(SongList songList){
    _collectSongList.remove(songList);
    notifyListeners();
  }

  void getSelfSongListData(BuildContext context) async{
    resetSongList();
    UserSpace result1 = await NetUtils1.getUserSpace(context, params: null);
    List<SongList> result2 = await NetUtils1.getUserCreatedSongList(context, params: null);
//    print(result1);
//    print(result2);
    _myFavoriteSong=result1.favoriteSongs;
    _selfCreateSongList=result2;
    _collectSongList=result1.favoriteSongLists;
    ///通知监听者
    notifyListeners();
  }
}
