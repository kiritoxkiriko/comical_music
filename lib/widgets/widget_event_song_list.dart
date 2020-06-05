import 'package:comical_music/model1/Song.dart';
import 'package:comical_music/model1/SongList.dart';
import 'package:comical_music/utils/net_utils1.dart';
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

class EventSongListWidget extends StatelessWidget {
  final SongList songList;

  EventSongListWidget(this.songList);


  @override
  Widget build(BuildContext context) {
    return Container(
      child:
    GestureDetector(
          onTap: () async {
            NavigatorUtil.goSongListPage(context, data: songList);
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
                    RoundedNetImage(
                      songList.image.path,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      radius: 5,
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
                        songList.name,
                        style: commonTextStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),);

  }
}
