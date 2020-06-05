import 'package:comical_music/model1/Song.dart';
import 'package:comical_music/utils/utils.dart';
import 'package:comical_music/widgets/widget_song_list_cover.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comical_music/widgets/common_text_style.dart';
import 'package:comical_music/utils/number_utils.dart';
import 'package:comical_music/widgets/v_empty_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:comical_music/widgets/widget_play_list_cover.dart';

/// 歌曲
class SongWidget extends StatelessWidget {
  final Song song;
  final int maxLines;
  final VoidCallback onTap;
  final int index;

  SongWidget({
  @required this.song,
    this.onTap,
    this.maxLines = -1,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        width: ScreenUtil().setWidth(200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            song.album.image.path == null ? Container() : SongListCoverWidget(
              song.album.image.path,
            ),
            index == null ? Container() : Text(index.toString(), style: commonGrayTextStyle,),
            VEmptyView(5),
            Text(
              song.name,
              style: smallCommonTextStyle,
              maxLines: maxLines != -1 ? maxLines : null,
              overflow: maxLines != -1 ? TextOverflow.ellipsis : null,
            ),
            Utils.convertSingerNames(song.singers) == null ? Container() : VEmptyView(2),
            Utils.convertSingerNames(song.singers) == null
                ? Container()
                : Text(
              Utils.convertSingerNames(song.singers),
              style: TextStyle(fontSize: 10, color: Colors.grey),
              maxLines: maxLines != -1 ? maxLines : null,
              overflow: maxLines != -1 ? TextOverflow.ellipsis : null,
            ),
          ],
        ),
      ),
    );
  }
}
