import 'package:comical_music/model1/Board.dart';
import 'package:comical_music/model1/Post.dart';
import 'package:comical_music/utils/net_utils1.dart';
import 'package:comical_music/widgets/widget_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WidgetEventPageTopBar extends StatefulWidget {
  PostRepository _postRepository;

  WidgetEventPageTopBar(this._postRepository);

  @override
  _EventPageTopBar createState() => _EventPageTopBar(_postRepository);
}

class _EventPageTopBar extends State<WidgetEventPageTopBar> {
  PostRepository _postRepository;

  _EventPageTopBar(this._postRepository);

//  PopupMenuEntry<Board> getBoardItem(){
//
//  }
  void refresh(int boardId) async {
    print("huaji"+boardId.toString());
    _postRepository.boardId = boardId;
    _postRepository.refresh();
  }

  Future<List<PopupMenuEntry<Board>>> _buildBoardMenu(BuildContext context) async {
    List<PopupMenuEntry<Board>> list = [];
    list.add(PopupMenuItem<Board>(
      value: Board() ,
      child: ListTile(
        title: Text("全部"),
      ),
    ));
    list.add(const PopupMenuDivider());
    var boards = await NetUtils1.getBoard(context);
    boards.forEach((e) {
      list.add(PopupMenuItem<Board>(
        value: e,
        child: ListTile(
          title: Text(e.name),
        ),
      ));
    });
    //print(boards);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CustomFutureBuilder<List<PopupMenuEntry<Board>>>(
                futureFunc: _buildBoardMenu,
                builder: (context, data) {
                  return PopupMenuButton<Board>(
                    child: IconButton(
                      icon: Icon(
                        Icons.dehaze,
                      ),
                    ),
                    padding: EdgeInsets.zero,
                    onSelected: (T) {
                      print("进入的");
                      print(T);
                      if (T == null) {
                        refresh(null);
                      } else {
                        refresh(T.id);
                      }
                    },
                    itemBuilder: (content) {
                      return data;
                    },
                  );
                },
              ),
              PopupMenuButton<String>(
                child: IconButton(
                  icon: Icon(
                    Icons.add_circle,
                    color: Colors.orange[700],
                    size: 40,
                  ),
                ),
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext content) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: "发送动态",
                    child: ListTile(
                      title: Text("发送动态"),
                      trailing: Icon(Icons.add_comment),
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: "上传音乐",
                    child: ListTile(
                      title: Text("上传音乐"),
                      trailing: Icon(Icons.library_music),
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: "上传歌单",
                    child: ListTile(
                      title: Text("上传歌单"),
                      trailing: Icon(Icons.queue_music),
                    ),
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
