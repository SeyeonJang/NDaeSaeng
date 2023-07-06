import 'package:dart_flutter/res/size_config.dart';
import 'package:dart_flutter/src/data/model/friend.dart';
import 'package:dart_flutter/src/presentation/mypage/friends_mock.dart';
import 'package:dart_flutter/src/presentation/vote/vimemodel/vote_cubit.dart';
import 'package:dart_flutter/src/presentation/vote/vote_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VoteStartView extends StatelessWidget {
  const VoteStartView({Key? key}) : super(key: key);

  int getFrinedCount() {
    List<Friend> friendList = FriendsMock().getFriends(); // TODO : mockup 넣어봤는데 친구 목록으로 고치기
    return friendList.length;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.defaultSize * 5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Flexible(
                flex: 1,
                child: SizedBox(),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "이번 Dart는?",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: SizeConfig.defaultSize * 5,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                    alignment: Alignment.center,
                    child: Icon(Icons.emoji_emotions,
                        size: SizeConfig.defaultSize * 20)),
              ),
              Flexible(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    List<Friend> friendList = FriendsMock().getFriends(); // TODO : mockup 넣어봤는데 친구 목록으로 고치기
                    int friendCount = friendList.length;
                    if (friendCount >= 4) {
                      // 시작
                      BlocProvider.of<VoteCubit>(context).stepStart();
                    } else {
                      // 친구 초대
                      // 카카오톡 공유
                    }
                  },
                  child: Builder(
                    builder: (context) {
                      List<Friend> friendList = FriendsMock().getFriends(); // TODO : mockup 넣어봤는데 친구 목록으로 고치기
                      int friendCount = friendList.length;
                      return Text(
                        friendCount >= 4 ? "시작하기" : "친구 4명 만들고 시작하기",
                        style: TextStyle(fontSize: SizeConfig.defaultSize * 4),
                      );
                    },
                  ),
                ),
              ),
              const Flexible(
                flex: 3,
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
