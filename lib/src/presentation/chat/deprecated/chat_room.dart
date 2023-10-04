import 'package:dart_flutter/res/config/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
const String _name = "닉네임";


@Deprecated("ChattingRoom으로 대채")
class ChatRoom extends StatefulWidget {
  const ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> with TickerProviderStateMixin {
  final List<ChatMessage> _message = <ChatMessage>[]; // 입력한 메시지를 저장하는 리스트
  final TextEditingController _textController = TextEditingController(); // 텍스트필드 제어용 컨트롤러
  bool _isComposing = false; // 텍스트필드에 입력된 데이터의 존재 여부

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text("팀이름", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8),),
      ),

      endDrawer: SafeArea(
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: SizeConfig.defaultSize * 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("지금 채팅 중인 팀은"),
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
                      const Text("23.5세"),
                        SizedBox(height: SizeConfig.defaultSize * 0.3,),
                      const Text("서울 인천 경기 부산 머머 머머 머머 머머")
                    ],
                  ),
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
                      Container( // 버리는 사진
                        width: SizeConfig.defaultSize * 3.7,
                        decoration: const BoxDecoration(
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
                      Text('상대팀 $i'),
                    ],
                  ),
                  onTap: () {
                    // id로 회원정보 값 가져오기 (userResponse 주면됨)
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatProfile()));
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
                        decoration: const BoxDecoration(
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
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatProfile()));
                  },
                ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey.shade200)))
            : null,
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                reverse: true, // 리스트뷰의 스크롤 방향을 반대로 변경. 최신 메시지가 하단에 추가됨
                itemCount: _message.length,
                itemBuilder: (_, index) => _message[index],
              ),
            ),
            // 구분선
            const Divider(height: 1.0),
            // 메시지 입력을 받은 위젯(_buildTextCompose)추가
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: _buildTextComposer(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: const IconThemeData(color: Color(0xffFF5C58)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                // 텍스트 입력 필드
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      cursorColor: const Color(0xffFF5C58),
                      controller: _textController,
                      // 입력된 텍스트에 변화가 있을 때 마다
                      onChanged: (text) {
                        setState(() {
                          _isComposing = text.isNotEmpty;
                        });
                      },
                      // 키보드상에서 확인을 누를 경우. 입력값이 있을 때에만 _handleSubmitted 호출
                      onSubmitted: _isComposing ? _handleSubmitted : null,
                      // 텍스트 필드에 힌트 텍스트 추가
                      decoration:
                      const InputDecoration.collapsed(hintText: "메시지를 입력해주세요"),
                    ),
                  ),
                ),
                // 전송 버튼
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  // 플랫폼 종류에 따라 적당한 버튼 추가
                  child: Theme.of(context).platform == TargetPlatform.iOS
                      ? CupertinoButton(
                    onPressed: _isComposing
                        ? () => _handleSubmitted(_textController.text)
                        : null,
                    child: const Text("보내기"),
                  )
                      : IconButton(
                    // 아이콘 버튼에 전송 아이콘 추가
                    icon: const Icon(Icons.send),
                    // 입력된 텍스트가 존재할 경우에만 _handleSubmitted 호출
                    onPressed: _isComposing
                        ? () => _handleSubmitted(_textController.text)
                        : null,
                  ),
                ),
              ],
            ),
              SizedBox(height: SizeConfig.defaultSize * 2,)
          ],
        ),
      ),
    );
  }

  // 메시지 전송 버튼이 클릭될 때 호출
  void _handleSubmitted(String text) {
    // 텍스트 필드의 내용 삭제
    _textController.clear();
    // _isComposing을 false로 설정
    setState(() {
      _isComposing = false;
    });
    // 입력받은 텍스트를 이용해서 리스트에 추가할 메시지 생성
    ChatMessage message = ChatMessage(
      text: text,
      // animationController 항목에 애니메이션 효과 설정
      // ChatMessage은 UI를 가지는 위젯으로 새로운 message가 리스트뷰에 추가될 때
      // 발생할 애니메이션 효과를 위젯에 직접 부여함
      animationController: AnimationController(
        duration: const Duration(milliseconds: 700),
        vsync: this,
      ),
    );
    // 리스트에 메시지 추가
    setState(() {
      _message.insert(0, message);
    });
    // 위젯의 애니메이션 효과 발생
    message.animationController.forward();
  }

  @override
  void dispose() {
    // 메시지가 생성될 때마다 animationController가 생성/부여 되었으므로 모든 메시지로부터 animationController 해제
    for (ChatMessage message in _message) {
      message.animationController.dispose();
    }
    super.dispose();
  }

}

class ChatMessage extends StatelessWidget {
  final String text; // 출력할 메시지
  final AnimationController animationController; // 리스트뷰에 등록될 때 보여질 효과

  const ChatMessage({super.key, required this.text, required this.animationController});

  @override
  Widget build(BuildContext context) {
    // 위젯에 애니메이션을 발생하기 위해 SizeTransition을 추가
    return SizeTransition(
      sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.ease),
      axisAlignment: 0.0,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              // 사용자명의 첫번째 글자를 서클 아바타로 표시
              child: Container( // 버리는 사진
                width: SizeConfig.defaultSize * 4,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/profile-mockup3.png',
                    width: SizeConfig.defaultSize * 4, // 이미지 크기
                    height: SizeConfig.defaultSize * 4,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.screenWidth * 0.65,
              // 컬럼 추가
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // 사용자명을 subhead 테마로 출력
                  Text(_name, style: TextStyle(fontSize: SizeConfig.defaultSize * 1.3, fontWeight: FontWeight.w600)),
                  // 입력받은 메시지 출력
                  Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12), topRight: Radius.circular(12), topLeft: Radius.circular(3)),
                      // color: Colors.grey.shade200,
                      border: Border.all(
                        color: const Color(0xffFF5C58)
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0), // 상하 및 좌우 공백 조절
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(text),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}