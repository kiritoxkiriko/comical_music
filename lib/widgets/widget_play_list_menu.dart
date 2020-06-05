import 'package:comical_music/model1/SongList.dart';
import 'package:comical_music/provider/song_list_model.dart';
import 'package:comical_music/utils/net_utils1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:comical_music/model/play_list.dart';
import 'package:comical_music/provider/user_model.dart';
import 'package:comical_music/utils/net_utils.dart';
import 'package:comical_music/utils/utils.dart';
import 'package:comical_music/widgets/common_text_style.dart';
import 'package:comical_music/widgets/widget_edit_play_list.dart';

class PlayListMenuWidget extends StatefulWidget {
  final SongList _songList;
  final SongListModel _model;

  PlayListMenuWidget(this._songList, this._model){
    //print("asdasdasdasdas");
    //print(this._model==null);
  }

  @override
  _PlayListMenuWidgetState createState() => _PlayListMenuWidgetState();
}

class _PlayListMenuWidgetState extends State<PlayListMenuWidget> {
  Widget _buildMenuItem(String img, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: ScreenUtil().setWidth(110),
        alignment: Alignment.center,
        child: Row(
          children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(140),
              child: Align(
                child: Image.asset(
                  img,
                  width: ScreenUtil().setWidth(80),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Expanded(
              child: Text(
                text,
                style: common14TextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(ScreenUtil().setWidth(40)),
              topRight: Radius.circular(ScreenUtil().setWidth(40))),
          color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: ScreenUtil().setWidth(100),
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
            alignment: Alignment.centerLeft,
            child: Text(
              '歌单：${widget._songList.name}',
              style: common14GrayTextStyle,
            ),
          ),
          Container(
            height: ScreenUtil().setWidth(0.5),
            color: Colors.black26,
          ),
          Offstage(
            offstage: widget._model.isMine(widget._songList),
            child: Container(
              color: Colors.grey,
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(140)),
              height: ScreenUtil().setWidth(0.3),
            ),
          ),
          _buildMenuItem('images/icon_del.png', '删除', () async {
            NetUtils1.deleteFavroteSongList(context, widget._songList.id).then((v){
              if(v != null&&v==true) Navigator.pop(context, true);
              else Utils.showToast('删除失败，请重试');
            });
          }),

          Container(
            color: Colors.grey,
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(140)),
            height: ScreenUtil().setWidth(0.3),
          ),
        ],
      ),
    );
  }
}
