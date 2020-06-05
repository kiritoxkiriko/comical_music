import 'dart:convert';

import 'package:comical_music/model1/Post.dart';
import 'package:comical_music/model1/UserSpace.dart';
import 'package:comical_music/utils/net_utils1.dart';
import 'package:comical_music/widgets/widget_event_page_top_bar.dart';
import 'package:comical_music/widgets/widget_event_song_deleted.dart';
import 'package:comical_music/widgets/widget_event_song_list.dart';
import 'package:comical_music/widgets/widget_event_song_list_deleted.dart';
import 'package:common_utils/common_utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:comical_music/model/event.dart';
import 'package:comical_music/model/event_content.dart';
//import 'package:comical_music/model/song.dart' as prefix0;
import 'package:comical_music/utils/event_special_text_span_builder.dart';
import 'package:comical_music/utils/navigator_util.dart';
import 'package:comical_music/utils/net_utils.dart';
import 'package:comical_music/utils/utils.dart';
import 'package:comical_music/widgets/common_text_style.dart';
import 'package:comical_music/widgets/h_empty_view.dart';
import 'package:comical_music/widgets/rounded_net_image.dart';
import 'package:comical_music/widgets/v_empty_view.dart';
import 'package:comical_music/widgets/widget_event_song.dart';
import 'package:comical_music/widgets/widget_event_video.dart';
import 'package:comical_music/widgets/widget_load_footer.dart';
import 'package:comical_music/widgets/widget_round_img.dart';

import '../../look_img_page.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _controller;
  FocusNode _blankNode = FocusNode();
  List<Post> _eventData = []; // 动态数据
  List<Post> _curRequestData = []; // 当前请求回来的动态数据，如果为空的话则代表没有数据了

  int lasttime = -1;
  PostRepository postRepository = PostRepository();

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
  }

  // 构建动态通用的模板（头像、粉丝等）
  Widget _buildCommonTemplate(
      Post data, Widget content) {
    TextSpan textSpan = TextSpan(
      children: [
        TextSpan(text: data.poster.username, style: common14BlueTextStyle),
      ],
    );

    // type 1：纯文字， 2：音乐，3：歌单
    switch (data.type) {
      case 1:
        break;
      case 2:
        textSpan.children.add(
          TextSpan(text: ' 分享音乐：', style: common14TextStyle),
        );
        break;
      case 3:
        textSpan.children.add(
          TextSpan(text: ' 分享歌单：', style: common14TextStyle),
        );
        break;
    }

    Widget title = RichText(text: textSpan);

    Widget picsWidget; // 图片widget
    int crossCount;
    List<BuildContext> picsContexts = [];

    if (data.sharedImages.isEmpty) {
      picsWidget = Container();
    } else if (data.sharedImages.length == 1) {
      picsWidget = Builder(builder: (context) {
        picsContexts.add(context);
        return GestureDetector(
          onTap: () {
            NavigatorUtil.goLookImgPage(
                context, data.sharedImages.map((p) => p.path).toList(), 0);

//            Navigator.push(context, LookImgRoute(data.pics.map((p) => p.originUrl).toList(), 0, picsContexts));
          },
          child: Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setWidth(15)),
            child: Utils.showNetImage(data.sharedImages[0].path),
          ),
        );
      });
    } else {
      if (data.sharedImages.length >= 2 && data.sharedImages.length < 5) crossCount = 2;
      if (data.sharedImages.length > 4) crossCount = 3;

      picsWidget = Padding(
        padding: EdgeInsets.only(top: ScreenUtil().setWidth(15)),
        child: GridView.custom(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossCount,
              mainAxisSpacing: ScreenUtil().setWidth(10),
              crossAxisSpacing: ScreenUtil().setWidth(10)),
          childrenDelegate: SliverChildBuilderDelegate((context, index) {
            var w = Builder(
              builder: (context) {
                picsContexts.add(context);
                return GestureDetector(
                  onTap: () {
                    NavigatorUtil.goLookImgPage(context,
                        data.sharedImages.map((p) => p.path).toList(), index);
//                  Navigator.push(context, LookImgRoute(data.pics.map((p) => p.originUrl).toList(), index, picsContexts));
                  },
                  child: Hero(
                    tag: '${data.sharedImages[index].path}$index',
                    child: RoundedNetImage(
                      data.sharedImages[index].path,
                      fit: BoxFit.cover,
                      radius: 5,
                    ),
                  ),
                );
              },
            );
            return w;
          }, childCount: data.sharedImages.length),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setWidth(15),
          horizontal: ScreenUtil().setWidth(30)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RoundImgWidget(
            data.poster.image!=null? data.poster.image.path:null,
            80,
          ),
          HEmptyView(10),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          title,
                          VEmptyView(5),
                          Text(
                            DateUtil.formatDateMs(data.time,
                                format: 'MM月dd日 HH:mm'),
                            style: smallGrayTextStyle,
                          ),
                        ],
                      ),
                    ),
//                    Chip(
//                            labelPadding: EdgeInsets.only(
//                                right: ScreenUtil().setWidth(15)),
//                            avatar: Icon(
//                              Icons.add,
//                              size: ScreenUtil().setWidth(30),
//                              color: Colors.white,
//                            ),
//                            backgroundColor: Colors.orange[700],
//                            label: Text(
//                              '拉黑',
//                              style: common14WhiteTextStyle,
//                            ))
                  ],
                ),
                VEmptyView(10),
                data == null
                    ? Container()
                    : ExtendedText(
                        data.content ?? "",
                        specialTextSpanBuilder: EventSpecialTextSpanBuilder(),
                        style: TextStyle(
                            fontSize: 15, color: Colors.black87, height: 1.5),
                      ),
                picsWidget,
                content == null
                    ? Container()
                    : Padding(
                        padding:
                            EdgeInsets.only(top: ScreenUtil().setWidth(15)),
                        child: content,
                      ),
                VEmptyView(20),
                _buildCommonBottomBar(data),
              ],
            ),
          )
        ],
      ),
    );
  }

  // 构建通用底部bar
  Widget _buildCommonBottomBar(Post data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
//        Expanded(
//          flex: 2,
//          child: Row(
//            mainAxisSize: MainAxisSize.min,
//            children: <Widget>[
//              Image.asset(
//                'images/icon_event_share.png',
//                width: ScreenUtil().setWidth(35),
//              ),
//              HEmptyView(5),
//              Text(
//                data.info.shareCount.toString(),
//                style: common13GrayTextStyle,
//              ),
//              HEmptyView(40),
//            ],
//          ),
//        ),
        Expanded(
            flex: 4,
            child: GestureDetector(
              onTap: (){
                NavigatorUtil.goReplyPage(context, post: data);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    'images/icon_event_comment.png',
                    width: ScreenUtil().setWidth(35),
                  ),
                  HEmptyView(5),
                  Text(
                    data.replyCount.toString(),
                    style: common13GrayTextStyle,
                  ),
                ],
              ),
            )
        ),

        Expanded(
          flex: 4,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'images/icon_event_commend.png',
                width: ScreenUtil().setWidth(35),
              ),
              HEmptyView(5),
              Text(
                data.likeCount.toString(),
                style: common13GrayTextStyle,
              ),
            ],
          ),
        ),
        Spacer(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GridTile(
      header: WidgetEventPageTopBar(postRepository),
      child: RefreshIndicator(
        child: LoadingMoreList(ListConfig<Post>(
            collectGarbage: (List<int> garbages) {
              garbages.forEach((index) {
                postRepository[index]
                    .sharedImages
                    .map((p) => p.path)
                    .toList()
                    .forEach((url) {
                  final provider = ExtendedNetworkImageProvider(url);
                  provider.evict();
                });
              });
            },
            itemBuilder: (context, curData, index) {
              //没用
              //var curContent;
              Widget contentWidget;
              // type 1：纯文字， 2：音乐，3：歌单
              switch (curData.type) {
                case 1:
                  break;
//              case 3:
//                curContent = EventContent.fromJson(json.decode(curData.json));
//                contentWidget = EventVideoWidget(curContent.video);
//                break;
                case 2:
                //curContent = EventContent.fromJson(json.decode(curData.json));
                //判断歌曲是否存在
                  if (curData.sharedSongs[0].exist) {
                    //这里要重新获取音乐链接，不然会缺少信息
                    contentWidget = EventSongWidget(curData.sharedSongs[0]);
                  } else {
                    contentWidget = EventDeletedSongWidget();
                  }
                  break;
                case 3:
                //curContent = EventContent.fromJson(json.decode(curData.json));
                //判断歌曲是否存在
                  if (curData.sharedSongLists[0].exist) {
                    contentWidget = EventSongListWidget(curData.sharedSongLists[0]);
                  } else {
                    contentWidget = EventDeletedSongListWidget();
                  }
                  break;
                default:
                //curContent = EventContent.fromJson(json.decode(curData.json));
                  break;
              }
              return _buildCommonTemplate(curData, contentWidget);
            },
            sourceList: postRepository)),
        onRefresh: () async {
          await postRepository.refresh();
        },
      )
    );
//    return RefreshIndicator(
//      child: LoadingMoreList(ListConfig<Post>(
//          collectGarbage: (List<int> garbages) {
//            garbages.forEach((index) {
//              postRepository[index]
//                  .sharedImages
//                  .map((p) => p.path)
//                  .toList()
//                  .forEach((url) {
//                final provider = ExtendedNetworkImageProvider(url);
//                provider.evict();
//              });
//            });
//          },
//          itemBuilder: (context, curData, index) {
//            //没用
//            //var curContent;
//            Widget contentWidget;
//            // type 1：纯文字， 2：音乐，3：歌单
//            switch (curData.type) {
//              case 1:
//                break;
////              case 3:
////                curContent = EventContent.fromJson(json.decode(curData.json));
////                contentWidget = EventVideoWidget(curContent.video);
////                break;
//              case 2:
//                //curContent = EventContent.fromJson(json.decode(curData.json));
//              //判断歌曲是否存在
//                if(curData.sharedSongs[0].exist){
//                  //这里要重新获取音乐链接，不然会缺少信息
//                  contentWidget = EventSongWidget(curData.sharedSongs[0]);
//                }else{
//                  contentWidget = EventDeletedSongWidget();
//                }
//                break;
//              default:
//                //curContent = EventContent.fromJson(json.decode(curData.json));
//                break;
//            }
//            return _buildCommonTemplate(curData, contentWidget);
//          },
//          sourceList: postRepository)),
//      onRefresh: () async {
//        await postRepository.refresh();
//      },
//    );
  }

  @override
  bool get wantKeepAlive => true;
}


