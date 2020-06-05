import 'dart:ui';
import 'package:comical_music/model1/SongList.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:comical_music/application.dart';
import 'package:comical_music/model/play_list.dart';
import 'package:comical_music/utils/utils.dart';
import 'package:comical_music/widgets/common_text_style.dart';
import 'package:comical_music/widgets/rounded_net_image.dart';
import 'package:comical_music/widgets/v_empty_view.dart';
import 'package:comical_music/widgets/widget_tag.dart';

class SongListDescDialog extends StatelessWidget {
  final SongList _data;

  SongListDescDialog(this._data);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Stack(
          children: <Widget>[
            Utils.showNetImage(
              _data.image.path,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaY: 30,
                sigmaX: 30,
              ),
              child: Container(
                color: Colors.black38,
              ),
            ),
            SafeArea(
              bottom: false,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    right: ScreenUtil().setWidth(40),
                    top: ScreenUtil().setWidth(10),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: ScreenUtil().setWidth(60),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(100)),
                      child: Column(
                        children: <Widget>[
                          VEmptyView(150),
                          Align(
                            alignment: Alignment.topCenter,
                            child: RoundedNetImage(
                              _data.image.path,
                              width: 400,
                              height: 400,
                            ),
                          ),
                          VEmptyView(40),
                          Text(
                            _data.name,
                            textAlign: TextAlign.center,
                            style: mWhiteBoldTextStyle,
                            softWrap: true,
                          ),
                          VEmptyView(40),
                          Image.asset(
                            'images/icon_line_1.png',
                            width: Application.screenWidth * 3 / 4,
                          ),
                          VEmptyView(20),
                          _data.tags.isEmpty
                              ? Container()
                              : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '标签：',
                                style: common14WhiteTextStyle,
                              ),
                              ..._data.tags
                                  .map((t) => TagWidget(t.name))
                                  .toList()
                            ],
                          ),
                          _data.tags.isEmpty ? Container() : VEmptyView(40),
                          Text(
                            _data.introduction,
                            style: common14WhiteTextStyle,
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
