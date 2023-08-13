import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/meet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MeetThreePeoplePage extends StatefulWidget {
  const MeetThreePeoplePage({super.key});

  @override
  State<MeetThreePeoplePage> createState() => _MeetThreePeoplePageState();
}

class _MeetThreePeoplePageState extends State<MeetThreePeoplePage> {
  CarouselController _carouselController = CarouselController();

  void showAlert() {
    QuickAlert.show(
        type: QuickAlertType.confirm,
        context: context,
        title: "3대3 과팅을 신청하시겠어요?",
        text: "제출하면 프로필을 수정할 수 없어요!\n신중히 제출해주세요!",
        confirmBtnText: '신청',
        cancelBtnText: '취소',
        onConfirmBtnTap: () {
          BlocProvider.of<MeetCubit>(context).stepThreePeopleDone();
          Navigator.of(context).pop(); // QuickAlert 닫기
        });
  }

  bool isChecked =
      false; // TODO : 체크박스 선택 여부 cubit, state 안 쓰고 프론트에서 처리했는데 상태 처리 따로 해야되면 고치기

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "3대3 과팅",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: SizeConfig.defaultSize * 2.2,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              BlocProvider.of<MeetCubit>(context).stepMeetLanding();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.defaultSize * 2,
              ),
              CarouselSlider.builder(
                carouselController: _carouselController,
                itemCount: 3,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        PeopleCardView(index: itemIndex),
                options: CarouselOptions(
                  height: SizeConfig.screenHeight * 0.6,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.75,
                  initialPage: 1,
                  enableInfiniteScroll: false,
                  // true -> loop
                  reverse: false,
                  // autoPlay: true,
                  // autoPlayInterval: Duration(seconds: 3),
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),

              SizedBox(
                height: SizeConfig.defaultSize * 3,
              ),
              Text(
                "우리 팀 프로필 완성하기",
                style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 2.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: SizeConfig.defaultSize * 2),

              Container(
                  height: SizeConfig.defaultSize * 30,
                  width: SizeConfig.screenWidth * 0.85,
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: EdgeInsets.all(SizeConfig.defaultSize * 2.4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("우리 팀은 \"정보통신전자공학부\"",
                            style: TextStyle(
                              // TODO : 학과 정보 서버 연결
                              fontSize: SizeConfig.defaultSize * 1.7,
                              fontWeight: FontWeight.w600,
                            )),
                        SizedBox(
                          height: SizeConfig.defaultSize * 4.0,
                        ),
                        Text("상대 팀과 만나고 싶은 지역",
                            style: TextStyle(
                              fontSize: SizeConfig.defaultSize * 1.7,
                              fontWeight: FontWeight.w600,
                            )),
                        SizedBox(
                          height: SizeConfig.defaultSize ,
                        ),
                        TextField(
                          autocorrect: true,
                          decoration: InputDecoration(
                            hintText: '입력 예시: 서울, 인천, 경기 북부',
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 1.5, horizontal: SizeConfig.defaultSize * 1.5),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(color: Colors.grey, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.indigoAccent),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.defaultSize * 2.5,
                        ),
                        Text("필요하다면 선택해주세요.",
                            style: TextStyle(
                              fontSize: SizeConfig.defaultSize * 1.7,
                              fontWeight: FontWeight.w600,
                            )),
                        Row(
                          children: [
                            Checkbox(
                                value: isChecked,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    isChecked = newValue!;
                                  });
                                }),
                            Text(
                              "같은 학과 만나고 싶지 않아요!",
                              style: TextStyle(
                                fontSize: SizeConfig.defaultSize * 1.7,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),

              SizedBox(
                height: SizeConfig.defaultSize * 5,
              ),
              //isChecked ? // 이거 버튼 나왔다 안나왔다 하는 로직 구현
              ElevatedButton(
                onPressed: () {
                  showAlert();
                },
                child: Text("3대3 과팅 신청하기",
                    style: TextStyle(
                      fontSize: SizeConfig.defaultSize * 1.7,
                      fontWeight: FontWeight.w500,
                    )),
              ), //: Container(),
            ],
          )),
    );
  }
}

class PeopleCardView extends StatelessWidget {
  int index;

  PeopleCardView({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return index == 1
        ? Container( // 본인
            clipBehavior: Clip.hardEdge,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.indigoAccent,
                borderRadius: BorderRadius.circular(20)),
            child: Column( // 내 프로필
              children: [
                SizedBox(height: SizeConfig.defaultSize*2,),
                Container( // 이미지
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100)),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset('assets/images/profile1.jpeg', width: SizeConfig.defaultSize * 10, height: SizeConfig.defaultSize * 10)
                    ),
                  )
                ),
                SizedBox(height: SizeConfig.defaultSize * 3),
                Padding(
                  padding: EdgeInsets.only(left: SizeConfig.defaultSize * 1.5 , right: SizeConfig.defaultSize * 1.5),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: SizeConfig.defaultSize * 0.9, right: SizeConfig.defaultSize * 0.9),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("팀장", style: TextStyle(
                              fontSize: SizeConfig.defaultSize * 1.7,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),),
                            Text("장세연  |  21학번(02)", style: TextStyle(
                              fontSize: SizeConfig.defaultSize * 1.7,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),),
                          ],
                        ),
                      ),
                      SizedBox(height: SizeConfig.defaultSize * 1.4),
                      Padding(
                        padding: EdgeInsets.only(left: SizeConfig.defaultSize * 0.9, right: SizeConfig.defaultSize * 0.9),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13)),
                              padding: EdgeInsets.only(top: SizeConfig.defaultSize * 0.5),
                              child: Text("MBTI",style: TextStyle(
                                fontSize: SizeConfig.defaultSize * 1.7,
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(13)),
                                padding: EdgeInsets.only(top: SizeConfig.defaultSize * 0.5, bottom: SizeConfig.defaultSize * 0.5, left: SizeConfig.defaultSize, right: SizeConfig.defaultSize),
                              child: Text("ENFJ", style: TextStyle(
                                fontSize: SizeConfig.defaultSize * 1.7,
                                color: Colors.indigoAccent,
                                fontWeight: FontWeight.w800,
                              ),),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.025,),
                      Container( // 투표 목록 들어갈 자리
                        height: SizeConfig.screenHeight * 0.23,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13)),
                        padding: EdgeInsets.all(SizeConfig.defaultSize),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            SizedBox(height: SizeConfig.screenHeight * 0.008),
                            Text("나를 대표하는 투표 3가지", style: TextStyle(
                              fontSize: SizeConfig.defaultSize * 1.7,
                              fontWeight: FontWeight.w600,
                            ),),
                            SizedBox(height: SizeConfig.screenHeight * 0.015),
                            Container( // TODO : 투표 넣어놓은 게 없다면 Container로 감싸서 빈 거 띄우기, for문으로 투표 개수만큼 만들기
                              height: SizeConfig.screenHeight * 0.05,
                              width: SizeConfig.screenWidth * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.indigoAccent,
                                  borderRadius: BorderRadius.circular(13)),
                              alignment: Alignment.center,
                              child: Text("첫인상이 좋은", style: TextStyle( // TODO : 글자 수 길어지면 ... 처리 하기
                                color: Colors.white,
                                fontSize: SizeConfig.defaultSize * 1.7,
                                fontWeight: FontWeight.w600,
                              ),),
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 0.005),
                            Container(
                              height: SizeConfig.screenHeight * 0.05,
                              width: SizeConfig.screenWidth * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.indigoAccent,
                                  borderRadius: BorderRadius.circular(13)),
                              alignment: Alignment.center,
                              child: Text("누가봐도 프로 갓생러", style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.defaultSize * 1.7,
                                fontWeight: FontWeight.w600,
                              ),),
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 0.005),
                            Container(
                              height: SizeConfig.screenHeight * 0.05,
                              width: SizeConfig.screenWidth * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.indigoAccent,
                                  borderRadius: BorderRadius.circular(13)),
                              alignment: Alignment.center,
                              child: Text("여행가면 꼭 데려가고 싶은", style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.defaultSize * 1.7,
                                fontWeight: FontWeight.w600,
                              ),),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.02),
                      GestureDetector(
                        onTap: () {
                          // TODO : 투표 목록 열기
                        },
                        child: Container(
                          height: SizeConfig.screenHeight * 0.05,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13)),
                          alignment: Alignment.center,
                          child: Text("내 투표 목록 수정하기", style: TextStyle(
                            color: Colors.indigoAccent,
                            fontSize: SizeConfig.defaultSize * 1.7,
                            fontWeight: FontWeight.w600,
                          ),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ))
        : Container( // 타인
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.indigoAccent,
                  width: 3.5,
                ),
                borderRadius: BorderRadius.circular(20)),
            child: Column( // 내 프로필
              children: [
                SizedBox(height: SizeConfig.defaultSize*2,),
                Container( // 이미지
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100)),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset('assets/images/profile2.jpeg', width: SizeConfig.defaultSize * 10, height: SizeConfig.defaultSize * 10)
                      ),
                    )
                ),
                SizedBox(height: SizeConfig.defaultSize * 3),
                Padding(
                  padding: EdgeInsets.only(left: SizeConfig.defaultSize * 1.5 , right: SizeConfig.defaultSize * 1.5),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: SizeConfig.defaultSize * 0.9, right: SizeConfig.defaultSize * 0.9),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("팀원", style: TextStyle(
                              fontSize: SizeConfig.defaultSize * 1.7,
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                            ),),
                            Text("장세연  |  21학번(02)", style: TextStyle(
                              fontSize: SizeConfig.defaultSize * 1.7,
                              color: Colors.indigoAccent,
                              fontWeight: FontWeight.w800,
                            ),),
                          ],
                        ),
                      ),
                      SizedBox(height: SizeConfig.defaultSize * 1.4),
                      Padding(
                        padding: EdgeInsets.only(left: SizeConfig.defaultSize * 0.9, right: SizeConfig.defaultSize * 0.9),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13)),
                              padding: EdgeInsets.only(top: SizeConfig.defaultSize * 0.5),
                              child: Text("MBTI",style: TextStyle(
                                fontSize: SizeConfig.defaultSize * 1.7,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(13)),
                              padding: EdgeInsets.only(top: SizeConfig.defaultSize * 0.5, bottom: SizeConfig.defaultSize * 0.5, left: SizeConfig.defaultSize, right: SizeConfig.defaultSize),
                              child: Text("ENFJ", style: TextStyle(
                                fontSize: SizeConfig.defaultSize * 1.7,
                                color: Colors.indigoAccent,
                                fontWeight: FontWeight.w800,
                              ),),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.025,),
                      Container( // 투표 목록 들어갈 자리
                        height: SizeConfig.screenHeight * 0.23,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(13)),
                        padding: EdgeInsets.all(SizeConfig.defaultSize),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            SizedBox(height: SizeConfig.screenHeight * 0.008),
                            Text("친구를 대표하는 투표 3가지", style: TextStyle(
                              fontSize: SizeConfig.defaultSize * 1.7,
                              fontWeight: FontWeight.w600,
                            ),),
                            SizedBox(height: SizeConfig.screenHeight * 0.015),
                            Container( // TODO : 투표 넣어놓은 게 없다면 Container로 감싸서 빈 거 띄우기, for문으로 투표 개수만큼 만들기
                              height: SizeConfig.screenHeight * 0.05,
                              width: SizeConfig.screenWidth * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.indigoAccent,
                                  borderRadius: BorderRadius.circular(13)),
                              alignment: Alignment.center,
                              child: Text("첫인상이 좋은", style: TextStyle( // TODO : 글자 수 길어지면 ... 처리 하기
                                color: Colors.white,
                                fontSize: SizeConfig.defaultSize * 1.7,
                                fontWeight: FontWeight.w600,
                              ),),
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 0.005),
                            Container(
                              height: SizeConfig.screenHeight * 0.05,
                              width: SizeConfig.screenWidth * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.indigoAccent,
                                  borderRadius: BorderRadius.circular(13)),
                              alignment: Alignment.center,
                              child: Text("누가봐도 프로 갓생러", style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.defaultSize * 1.7,
                                fontWeight: FontWeight.w600,
                              ),),
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 0.005),
                            Container(
                              height: SizeConfig.screenHeight * 0.05,
                              width: SizeConfig.screenWidth * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.indigoAccent,
                                  borderRadius: BorderRadius.circular(13)),
                              alignment: Alignment.center,
                              child: Text("여행가면 꼭 데려가고 싶은", style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.defaultSize * 1.7,
                                fontWeight: FontWeight.w600,
                              ),),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.02),
                      GestureDetector(
                        onTap: () {
                          // TODO : 투표 목록 열기
                        },
                        child: Container(
                          height: SizeConfig.screenHeight * 0.05,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13),
                            border: Border.all(
                              color: Colors.indigoAccent,
                              width: 1,
                            ),),
                          alignment: Alignment.center,
                          child: Text("친구 삭제하기", style: TextStyle(
                            color: Colors.indigoAccent,
                            fontSize: SizeConfig.defaultSize * 1.7,
                            fontWeight: FontWeight.w600,
                          ),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
    );
  }
}
