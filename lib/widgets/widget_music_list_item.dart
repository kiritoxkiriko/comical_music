import 'package:comical_music/model1/Song.dart';
import 'package:comical_music/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:comical_music/model/music.dart';
import 'package:comical_music/widgets/rounded_net_image.dart';
import 'package:comical_music/widgets/v_empty_view.dart';

import '../application.dart';
import 'common_text_style.dart';
import 'h_empty_view.dart';

class WidgetMusicListItem extends StatelessWidget {
  final Song _data;
  final int _index;
  final VoidCallback onTap;

  WidgetMusicListItem(this._data, this._index, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        width: Application.screenWidth,
        height: ScreenUtil().setWidth(120),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _index == null && _data.album.image.path == null
                ? Container()
                : HEmptyView(15),
//            _data.album.image.path == null
//                ? Container()
//                : RoundedNetImage(
//                    _data.album.image.path,
//                    width: 100,
//                    height: 100,
//                    radius: 5,
//                  ),
            _index == null
                ? Container()
                : Container(
                    alignment: Alignment.center,
                    width: ScreenUtil().setWidth(60),
                    height: ScreenUtil().setWidth(50),
                    child: Text(
                      _index.toString(),
                      style: mGrayTextStyle,
                    ),
                  ),
            _index == null && _data.album.image.path == null
                ? Container()
                : HEmptyView(10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _data.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: commonTextStyle,
                  ),
                  VEmptyView(10),
                  Text(
                    Utils.convertSingerNames(_data.singers),
                    style: smallGrayTextStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container()
            ),
            Align(
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(Icons.add),
                //TODO 添加歌曲
                onPressed: () {},
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
