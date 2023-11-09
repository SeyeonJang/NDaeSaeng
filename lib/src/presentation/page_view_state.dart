import '../domain/entity/user.dart';

class PageViewState {
  late User myInfo;
  late bool showPopup;
  late int openCount;

  PageViewState({
    required this.myInfo,
    required this.showPopup,
    required this.openCount
  });

  PageViewState copy() => PageViewState(
      myInfo: myInfo,
      showPopup: showPopup,
      openCount: openCount
  );

  Map<String, dynamic> toJson() => <String, dynamic> {
    'myInfo': myInfo.toJson(),
    'popup': showPopup,
    'openCount': openCount
  };

  PageViewState fromJson(Map<String, dynamic> json) => PageViewState(
      myInfo: User.fromJson(json['myInfo']),
      showPopup: json['popup'] as bool,
      openCount: json['openCount'] as int,
  );
}
