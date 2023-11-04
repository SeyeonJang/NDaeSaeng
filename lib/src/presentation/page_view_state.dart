class PageViewState {
  late bool popup;
  late int openCount;

  PageViewState({
    required this.popup,
    required this.openCount
  });

  PageViewState copy() => PageViewState(popup: popup, openCount: openCount);

  Map<String, dynamic> toJson() => <String, dynamic> {
    'popup': popup,
    'openCount': openCount
  };

  PageViewState fromJson(Map<String, dynamic> json) => PageViewState(
      popup: json['popup'] as bool,
      openCount: json['openCount'] as int,
  );
}
