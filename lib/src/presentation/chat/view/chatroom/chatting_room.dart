import 'package:chatview/chatview.dart';
import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/presentation/chat/view/chat_profile.dart';
import 'package:flutter/material.dart';

class ChattingRoom extends StatefulWidget {
  const ChattingRoom({super.key});

  @override
  State<ChattingRoom> createState() => _ChattingRoomState();
}

class _ChattingRoomState extends State<ChattingRoom> {
  String message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text("팀이름", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8),),
      ),

      endDrawerEnableOpenDragGesture: false,
      endDrawer: SafeArea(
        child: Drawer(
          surfaceTintColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Padding(
                  padding: EdgeInsets.only(top: SizeConfig.defaultSize * 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("지금 채팅 중인 팀은"),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('한양대학교 ', style: TextStyle(
                              fontSize: SizeConfig.defaultSize * 1.8, fontWeight: FontWeight.w600
                          ),),
                          // if (chatState.userResponse.personalInfo?.verification.isVerificationSuccess ?? false)
                          Image.asset("assets/images/check.png", width: SizeConfig.defaultSize * 1.55),
                        ],
                      ),
                      SizedBox(height: SizeConfig.defaultSize * 2,),
                      Text("23.5세"),
                      SizedBox(height: SizeConfig.defaultSize * 0.3,),
                      Text("서울 인천 경기 부산 머머 머머 머머 머머")
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: SizeConfig.defaultSize * 1.8, top: SizeConfig.defaultSize * 2, bottom: SizeConfig.defaultSize * 2),
                child: Text("상대팀이름", style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 1.5,
                    fontWeight: FontWeight.w400
                ),),
              ),
              for (int i=1; i<=3; i++)
                ListTile(
                  title: Row(
                    children: [
                      Row(
                        children: [
                          Container( // 버리는 사진
                            width: SizeConfig.defaultSize * 3.7,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Image.asset(
                                  'assets/images/profile-mockup3.png',
                                  width: SizeConfig.defaultSize * 3.7, // 이미지 크기
                                  height: SizeConfig.defaultSize * 3.7
                              ),
                            ),
                          ),
                          SizedBox(width: SizeConfig.defaultSize * 1.3),
                          Text('상대팀 $i', style: TextStyle(
                            fontSize: SizeConfig.defaultSize * 1.5
                          ),),
                        ],
                      ),
                      SizedBox(width: SizeConfig.defaultSize * 4,),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("학과학과학과학과학과", style: TextStyle(
                            fontSize: SizeConfig.defaultSize * 1.2,
                            overflow: TextOverflow.ellipsis
                      ),),
                          ],
                        ))
                    ],
                  ),
                  onTap: () {
                    // id로 회원정보 값 가져오기 (userResponse 주면됨)
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatProfile()));
                  },
                ),
              Padding(
                padding: EdgeInsets.only(left: SizeConfig.defaultSize * 1.8, top: SizeConfig.defaultSize * 2, bottom: SizeConfig.defaultSize * 2),
                child: Text("우리팀이름", style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 1.5,
                    fontWeight: FontWeight.w400
                ),),
              ),
              for (int i=1; i<=3; i++)
                ListTile(
                  title: Row(
                    children: [
                      Container( // 버리는 사진
                        width: SizeConfig.defaultSize * 3.7,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(
                              'assets/images/profile-mockup3.png',
                              width: SizeConfig.defaultSize * 3.7, // 이미지 크기
                              height: SizeConfig.defaultSize * 3.7
                          ),
                        ),
                      ),
                      SizedBox(width: SizeConfig.defaultSize * 1.3),
                      Text('우리팀 $i'),
                    ],
                  ),
                  onTap: () {
                    // id로 회원정보 값 가져오기 (userResponse 주면됨)
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatProfile()));
                  },
                ),
            ],
          ),
        ),
      ),

      body: ChatView(
        currentUser: currentUser,
        chatController: chatController,
        chatViewState: ChatViewState.hasMessages,
        onSendTap: onSendTap,

        featureActiveConfig: const FeatureActiveConfig( // 기본적으로 true로 되어있는 설정 끄기 (답장, 이모지 등)
          enableSwipeToReply: false,
          enableReactionPopup: false,
          enableDoubleTapToLike: false,
          enableReplySnackBar: false,
          enableCurrentUserProfileAvatar: false,
          enableSwipeToSeeTime: true
          // enablePagination: true, // Pagination
        ),

        sendMessageConfig: SendMessageConfiguration( // 메시지 입력창 설정
          textFieldBackgroundColor: Colors.grey.shade100,
          enableCameraImagePicker: false, // 카메라 제거
          enableGalleryImagePicker: false, // 갤러리 제거,
          allowRecordingVoice: false, // 녹음(음성메시지) 제거
          sendButtonIcon: Icon(Icons.send_rounded, color: Color(0xffFF5C58),),
          textFieldConfig: TextFieldConfiguration(
            hintText: "메시지를 입력해주세요",
            textStyle: TextStyle(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        chatBubbleConfig: ChatBubbleConfiguration(
          outgoingChatBubbleConfig: ChatBubble( // 내가 보낸 채팅
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            linkPreviewConfig: LinkPreviewConfiguration(
              proxyUrl: "Proxy URL", // Need for web
              backgroundColor: Color(0xff272336),
              bodyStyle: TextStyle(color: Colors.white),
              titleStyle: TextStyle(color: Colors.white),
            ),
            color: Color(0xffFF5C58),
          ),
          inComingChatBubbleConfig: ChatBubble( // 상대방 채팅
            linkPreviewConfig: LinkPreviewConfiguration(
              proxyUrl: "Proxy URL", // Need for web
              linkStyle: TextStyle(fontSize: 14, color: Colors.black),
              backgroundColor: Color(0xff9f85ff),
              bodyStyle: TextStyle(color: Colors.black),
              titleStyle: TextStyle(color: Colors.black),
            ),
            textStyle: TextStyle(color: Colors.black),
            senderNameTextStyle: TextStyle(color: Colors.black),
            color: Colors.grey.shade200,
          ),
        ),

        chatBackgroundConfig: const ChatBackgroundConfiguration( // 채팅방 배경
          backgroundImage: "image URL",
          messageTimeIconColor: Colors.grey,
          messageTimeTextStyle: TextStyle(color: Colors.grey),
          defaultGroupSeparatorConfig: DefaultGroupSeparatorConfiguration(
            textStyle: TextStyle(
              color: Colors.grey,
              fontSize: 17,
            ),
          ),
          backgroundColor: Colors.white,
        ),

        // 이모지 선택
        // reactionPopupConfig: ReactionPopupConfiguration(
        //   emojiConfig: const EmojiConfiguration(
        //     emojiList: [
        //       "❤️", "🥰", "👍🏻", "🥺", "💌", "🌟",
        //     ],
        //     size: 24,
        //   ),
        //   glassMorphismConfig: GlassMorphismConfiguration(
        //     backgroundColor: Colors.white,
        //     borderRadius: 14,
        //     borderColor: Colors.white,
        //     strokeWidth: 4,
        //   ),
        //   shadow: BoxShadow(
        //     color: Colors.grey.shade400,
        //     blurRadius: 20,
        //   ),
        //   backgroundColor: Colors.grey.shade200,
        //   // onEmojiTap: (emoji, messageId) =>
        //   //     chatController. setReaction(
        //   //       emoji: emoji,
        //   //       messageId: messageld,
        //   //       userId: currentUser.id,
        //   //     ),
        // ),

        // messageConfig: MessageConfiguration( // 채팅 한 개에 이모지 달아주는 뷰
        //   messageReactionConfig: MessageReactionConfiguration(
        //     backgroundColor: Color(0xff383152),
        //     borderColor: Color(0xff383152),
        //     reactedUserCountTextStyle:
        //     TextStyle(color: Colors.white),
        //     reactionCountTextStyle:
        //     TextStyle(color: Colors.white),
        //     reactionsBottomSheetConfig: ReactionsBottomSheetConfiguration(
        //       backgroundColor: Color(0xff272336),
        //       reactedUserTextStyle: TextStyle(
        //         color: Colors.white,
        //       ),
        //       reactionWidgetDecoration: BoxDecoration(
        //         color: Color(0xff383152),
        //         boxShadow: [
        //           BoxShadow(
        //             color: Colors.black12,
        //             offset: const Offset(0, 20),
        //             blurRadius: 40,
        //           )
        //         ],
        //         borderRadius: BorderRadius.circular(10),
        //       ),
        //     ),
        //   ),
        //   // imageMessageConfig: ImageMessageConfiguration(
        //   //   margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        //   //   shareIconConfig: ShareIconConfiguration(
        //   //     defaultIconBackgroundColor: Color(0xff383152),
        //   //     defaultIconColor: Colors.white,
        //   //   ),
        //   // ),
        // ),
      ),
    );
  }

  final currentUser = ChatUser(
    id: '1',
    name: '장세연',
    profilePhoto: 'Profile photo URL',
  );
  // final _userTwo = ChatUser(
  //   id: '2',
  //   name: '성서진',
  //   profilePhoto: 'Profile photo URL',
  // );
  // final _userThree = ChatUser(
  //   id: '3',
  //   name: '초롱',
  //   profilePhoto: 'Profile photo URL',
  // );

  final chatController = ChatController(
    initialMessageList: [
      Message(
        id: '1',
        message: "안녕",
        createdAt: DateTime.now(),
        sendBy: '1', // userId of who sends the message
      ),
      Message(
        id: '2',
        message: "하세요!",
        createdAt: DateTime.now(),
        sendBy: '2',
      ),
      Message(
        id: '3',
        message: "채팅채팅",
        createdAt: DateTime.now(),
        sendBy: '3',
      ),
    ],
    scrollController: ScrollController(),
    chatUsers: [
      ChatUser(
        id: '2',
        name: '성서진',
        profilePhoto: 'https://www.wyzowl.com/wp-content/uploads/2022/04/img_624d8245533d8.jpg',
      ),
      ChatUser(
        id: '3',
        name: '초롱',
        profilePhoto: 'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FEPjzf%2FbtstxQOVRym%2FwTZOsCvGjwnWtU1qaT575k%2Fimg.png',
      )
    ],
  );

  void onSendTap(String message, ReplyMessage replyMessage, MessageType messageType) {
    chatController.addMessage(
      Message(
        id: '1', // This can be the next message-id if you need to add according to your usecase
        createdAt: DateTime.now(),
        message: message,
        sendBy: '1',
        messageType: messageType,
      ),
    );
  }
}
