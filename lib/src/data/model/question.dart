class Question {
  String? questionId;
  String? content;
  String? icon;

  Question({this.questionId, this.content, this.icon});

  Question.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    content = json['content'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['content'] = this.content;
    data['icon'] = this.icon;
    return data;
  }

  @override
  String toString() {
    return 'Question{questionId: $questionId, content: $content, icon: $icon}';
  }
}