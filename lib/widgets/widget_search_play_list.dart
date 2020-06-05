import 'package:comical_music/model1/SongList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:comical_music/model/recommend.dart';
import 'package:comical_music/utils/navigator_util.dart';
import 'package:comical_music/utils/number_utils.dart';
import 'package:comical_music/widgets/rounded_net_image.dart';
import 'package:comical_music/widgets/v_empty_view.dart';

import 'common_text_style.dart';
import 'h_empty_view.dart';

class SearchPlayListWidget extends StatelessWidget {

  final SongList songList;
   double width=140;


  SearchPlayListWidget(this.songList, this.width);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        //TODO
//        NavigatorUtil.goPlayListPage(context, data: Recommend(
//          id: id,
//          name: name,
//          picUrl: url,
//          playcount: playCount,
//        ));
      },
      child: Padding(
        padding:
        EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
        child: Row(
          children: <Widget>[
            RoundedNetImage(
              songList.image.path,
              width: width,
              height: width,
              radius: 8,
            ),
            HEmptyView(10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    songList.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: common14TextStyle,
                  ),
                  VEmptyView(10),
                  Text(
                    songList.songs.length.toString()+"首 by"+songList.creator.username,
                    style: smallGrayTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
