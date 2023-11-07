import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/presentation/feed/viewmodel/feed_cubit.dart';
import 'package:flutter/material.dart';
import 'package:dart_flutter/src/domain/entity/comment.dart';
import 'package:intl/intl.dart';

import '../../../../common/util/analytics_util.dart';

class CommentComponent extends StatefulWidget {
  late Comment comment;
  late FeedCubit feedCubit;

  CommentComponent({super.key, required this.comment, required this.feedCubit});

  @override
  State<CommentComponent> createState() => _CommentComponentState();
}

class _CommentComponentState extends State<CommentComponent> {
  late int commentId;
  late int userId;
  late bool liked;
  late int likes;
  late String universityName;
  late String nickname;
  late String createdAt;
  late String content;

  @override
  void initState() {
    super.initState();
    setState(() {
      commentId = widget.comment.id;
      liked = widget.comment.liked;
      likes = widget.comment.likes;
      universityName = widget.comment.writer.university?.name ?? "XX대학교";
      nickname = widget.comment.writer.personalInfo?.recommendationCode ?? "익명";
      createdAt = DateFormat('MM/dd HH:mm').format(widget.comment.createdAt);
      content = widget.comment.content;
      userId = widget.comment.writer.personalInfo?.id ?? 0;
    });
  }

  void pressedLikeButton() {
    if (liked) {
      return;
    }
    setState(() {
      liked = !liked;
      likes++;
    });

    try {
      widget.feedCubit.postLikeComment(commentId);
    } catch (e, trace) {
      // 좋아요 요청 실패시 원상복구
      setState(() {
        liked = !liked;
        likes--;
      });
    }
  }

  void pressedDeleteButton() {

    showDialog<String>(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: Text('댓글을 삭제하시겠어요?', style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8), textAlign: TextAlign.center,),
        content: Text("삭제시에 복구할 수 없어요!"),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext, '취소');
            },
            child: const Text('취소', style: TextStyle(color: Color(0xffFF5C58)),),
          ),
          TextButton(
            onPressed: () async {
              ToastUtil.showToast("삭제하기");
              widget.feedCubit.deleteComment(commentId);
              Navigator.pop(dialogContext);
              // Navigator.pop(context, true);
            },
            child: const Text('삭제', style: TextStyle(color: Color(0xffFF5C58)),),
          ),
        ],
      ),
    );
  }

  void pressedReportButton() {
    AnalyticsUtil.logEvent('커뮤니티_투표_댓글_더보기_신고하기_버튼터치');
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('사용자를 신고하시겠어요?'),
        content: const Text('엔대생에서 빠르게 신고 처리를 해드려요!'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, '취소');
              AnalyticsUtil.logEvent('커뮤니티_투표_댓글_더보기_신고하기_취소');
            },
            child: const Text('취소', style: TextStyle(color: Color(0xffFE6059)),),
          ),
          TextButton(
            onPressed: () => {
              AnalyticsUtil.logEvent('커뮤니티_투표_댓글_더보기_신고하기_신고확정', properties: {
                'commentId': commentId,
                'content': content,
                'userId' : userId,
              }
              ),

              widget.feedCubit.reportComment(commentId),
              Navigator.pop(context, '신고'),
              ToastUtil.showMeetToast("사용자가 신고되었어요!", 1),
            },
            child: const Text('신고', style: TextStyle(color: Color(0xffFE6059)),),
          ),
        ],
      ),
    );


  }

  @override
  Widget build(BuildContext context) {
    // return Container(color: Colors.blue, width: 100, height: 100,);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text("$universityName ", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w600)),
                Text(nickname, style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w600)),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: pressedLikeButton,
                  icon: Icon(
                    Icons.thumb_up_alt_outlined,
                    size: SizeConfig.defaultSize * 1.5,
                    color: liked ? Colors.red : Colors.grey,
                  ),
                ),

                PopupMenuButton<String>(
                  icon: Icon(Icons.more_horiz_rounded, size: SizeConfig.defaultSize * 1.5, color: Colors.grey,),
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  padding: EdgeInsets.zero,
                  onSelected: (value) {
                    // 팝업 메뉴에서 선택된 값 처리
                    if (value == 'remove') {
                      pressedDeleteButton();
                    }
                    if (value == 'report') {
                      pressedReportButton();
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<String>(
                        value: 'remove',
                        child: Text("삭제하기", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5)),
                      ),
                      PopupMenuItem<String>(
                        value: 'report',
                        child: Text("신고하기", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5)),
                      ),
                    ];
                  },
                ),
              ],
            ),
          ],
        ),
        Container(height: SizeConfig.defaultSize * 1,),

        Text(content, style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5)),
        Container(height: SizeConfig.defaultSize * 1,),

        Row(
          children: [
            Text(createdAt, style: TextStyle(color: Colors.grey, fontSize: SizeConfig.defaultSize * 1.2),),
            Icon(Icons.thumb_up_alt_outlined, size: SizeConfig.defaultSize * 1.2, color: Colors.red,),
            Text(" $likes", style: TextStyle(color: Colors.red, fontSize: SizeConfig.defaultSize * 1.2),),
          ],
        )
      ],
    );
  }
}
