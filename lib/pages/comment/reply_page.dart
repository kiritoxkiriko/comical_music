import 'package:comical_music/model1/PageResponseData.dart';
import 'package:comical_music/model1/Post.dart';
import 'package:comical_music/model1/Reply.dart';
import 'package:comical_music/model1/Song.dart';
import 'package:comical_music/model1/SongComment.dart';
import 'package:comical_music/utils/net_utils1.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:comical_music/model/comment_head.dart';
import 'package:comical_music/model/song_comment.dart';
import 'package:comical_music/pages/comment/comment_type.dart';
import 'package:comical_music/utils/net_utils.dart';
import 'package:comical_music/utils/number_utils.dart';
import 'package:comical_music/utils/utils.dart';
import 'package:comical_music/widgets/common_text_style.dart';
import 'package:comical_music/widgets/h_empty_view.dart';
import 'package:comical_music/widgets/rounded_net_image.dart';
import 'package:comical_music/widgets/v_empty_view.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:comical_music/widgets/widget_load_footer.dart';
import 'package:comical_music/widgets/widget_round_img.dart';

import 'comment_input_widget.dart';

class ReplyPage extends StatefulWidget {
  final Post post;
  //List<Reply> commentData = [];
  Map<String, int> params;


  ReplyPage(this.post);

  @override
  _ReplyPageState createState() => _ReplyPageState();
}

class _ReplyPageState extends State<ReplyPage> {
  List<Reply> commentData = [];
  PageResponseData replyPage;
  EasyRefreshController _controller;
  FocusNode _blankNode = FocusNode();

  @override
  void initState() {
    //super.initState();
    _controller = EasyRefreshController();
    Set<String> a={};

    ///设置抬头
    commentData.add(null);
    WidgetsBinding.instance.addPostFrameCallback((d) {
      widget.params = {'postId': widget.post.id};
      if (commentData.length<2) {
        _request();
      }
    });
  }

  void _request() async {
    replyPage = await NetUtils1.getReply(context, params: widget.params);
    setState(() {

      if (replyPage.totalElements > 0) {
        replyPage.data.forEach((element) {
          commentData.add(Reply.fromJson(element));
        });
        //widget.params['page']++;
        //commentData.addAll(songCommentPage.data);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return replyPage == null ? Container(
      height: ScreenUtil().setWidth(400),
      alignment: Alignment.center,
      child: CupertinoActivityIndicator(),
    ) :
    Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Text('回复(${replyPage.totalElements})'),
        ),
        body: Stack(
          children: <Widget>[
            Listener(
              onPointerDown: (d) {
                FocusScope.of(context).requestFocus(_blankNode);
              },
              child: EasyRefresh(
                footer: LoadFooter(),
                controller: _controller,
                onLoad: () async {
                  widget.params['page'] == null
                      ? widget.params['page'] = 2
                      : widget.params['page']++;
                  _request();
                  _controller.finishLoad(
                      noMore: !replyPage.hasNext);
                },
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      buildHead(),
                      Container(
                        height: ScreenUtil().setWidth(20),
                        color: Color(0xfff5f5f5),
                      ),
                      ListView.separated(
                          padding: EdgeInsets.only(
                              left: ScreenUtil().setWidth(30),
                              right: ScreenUtil().setWidth(30),
                              bottom: ScreenUtil().setWidth(50)),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return buildCommentItem(commentData[index]);
                          },
                          separatorBuilder: (context, index) {
                            if (commentData[index]==null)
                              return Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setWidth(30)),
                              );
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: ScreenUtil().setWidth(30)),
                              height: ScreenUtil().setWidth(1.5),
                              color: Color(0xfff5f5f5),
                            );
                          },
                          itemCount: commentData.length),
                    ],
                  ),
                ),
              ),
            ),

            Align(
              child: CommentInputWidget((content) {
                // 提交评论
                NetUtils1.sendReply(context, params: {
                  'postId': widget.post.id,
                  'content': content
                }).then((r) {
                  Utils.showToast('回复成功！');
                  setState(() {
                    commentData.insert(commentData
                        .map((c) => c)
                        .toList()
                        .indexOf(null) +
                        1,
                        r);
                  });
                });
              }),
              alignment: Alignment.bottomCenter,
            )
          ],
        ));
  }

  Widget buildCommentItem(Reply data) {
    if (data==null)
      return Padding(
        padding: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
        ///设置抬头边距
        child: Text(
          "所有回复",
          style: bold17TextStyle,
        ),
      );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RoundImgWidget(data.replier.image.path, 70),
        HEmptyView(10),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    data.replier.username,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setWidth(5)),
                    child: Text(
                      '${NumberUtils.amountConversion(data.likeCount)}',
                      style: common14GrayTextStyle,
                    ),
                  ),
                  HEmptyView(5),
                  Image.asset(
                    'images/icon_parise.png',
                    width: ScreenUtil().setWidth(35),
                    height: ScreenUtil().setWidth(35),
                  )
                ],
              ),
              VEmptyView(5),
              Text(
                DateUtil.getDateStrByMs(data.time,
                    format: DateFormat.YEAR_MONTH_DAY),
                style: smallGrayTextStyle,
              ),
              VEmptyView(20),
              Text(
                data.content,
                style:
                TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildHead() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(30),
          vertical: ScreenUtil().setWidth(20)),
      child: Row(
        children: <Widget>[
          RoundedNetImage(
            widget.post.poster.image.path,
            width: 120,
            height: 120,
            radius: 4,
          ),
          HEmptyView(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  widget.post.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: commonTextStyle,
                ),
                VEmptyView(10),
                Text(
                  widget.post.poster.username,
                  style: common14TextStyle,
                )
              ],
            ),
          ),
          HEmptyView(20),
          Icon(Icons.keyboard_arrow_right)
        ],
      ),
    );
  }
}
