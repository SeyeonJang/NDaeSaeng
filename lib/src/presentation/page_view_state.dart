import '../domain/entity/user.dart';

class PageViewState {
  late User myInfo;
  late bool popup;
  late int openCount;

  PageViewState({
    required this.myInfo,
    required this.popup,
    required this.openCount
  });

  PageViewState copy() => PageViewState(
      myInfo: myInfo,
      popup: popup,
      openCount: openCount
  );

  Map<String, dynamic> toJson() => <String, dynamic> {
    'myInfo': myInfo.toJson(),
    'popup': popup,
    'openCount': openCount
  };

  PageViewState fromJson(Map<String, dynamic> json) => PageViewState(
      myInfo: User.fromJson(json['myInfo']),
      popup: json['popup'] as bool,
      openCount: json['openCount'] as int,
  );
}
