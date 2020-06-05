import 'package:comical_music/model1/Song.dart';
import 'package:comical_music/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:comical_music/provider/play_songs_model.dart';
import 'package:comical_music/utils/navigator_util.dart';
import 'package:comical_music/widgets/common_text_style.dart';
import 'package:comical_music/widgets/h_empty_view.dart';
import 'package:comical_music/widgets/rounded_net_image.dart';
import 'package:comical_music/widgets/v_empty_view.dart';
import 'package:provider/provider.dart';

class EventDeletedSongListWidget extends StatelessWidget {
  //final Song song;
  //final Song songList;

  EventDeletedSongListWidget();

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaySongsModel>(
      builder: (context, model, _) {
        return GestureDetector(
          onTap: () {
            //model.playSong(song);
            //NavigatorUtil.goSongListPage(context,);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10)),
              color: Color(0xFFf3f3f3),
            ),
            padding: EdgeInsets.all(ScreenUtil().setWidth(13)),
            child: Row(
              children: <Widget>[
                Stack(
                  children: <Widget>[
//                    RoundedNetImage(
//                      song.album.image.path,
//                      width: 100,
//                      height: 100,
//                      fit: BoxFit.cover,
//                      radius: 5,
//                    ),
//                    ),
                    Container(
                      width: ScreenUtil().setWidth(100),
                      height: ScreenUtil().setWidth(100),
                      alignment: Alignment.center,
                      /*child: Image.asset(
                        'images/icon_event_play.png',
                        width: ScreenUtil().setWidth(70),
                        height: ScreenUtil().setWidth(70),
                      ),*/
                    ),
                  ],
                ),
                HEmptyView(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "歌单已被删除",
                        style: commonTextStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      VEmptyView(5),
                      Text(
                        '',
                        style: common13GrayTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
