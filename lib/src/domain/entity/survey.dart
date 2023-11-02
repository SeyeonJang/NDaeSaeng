import 'package:dart_flutter/src/domain/entity/option.dart';

class Survey {
  final int _id;
  final String _question;
  final List<Option> _options;
  final bool _picked;
  final int _pickedOption;

  Survey({
    required int id,
    required String question,
    required List<Option> options,
    required bool picked,
    required int pickedOption
  }) : _id = id, _question = question, _options = options, _picked = picked, _pickedOption = pickedOption;

  factory Survey.fromJson(Map<String, dynamic> json) {
    final int parsedId = json['id'];
    final String parsedQuestion = json['question'];

    List<Option> parsedOptions = [];
    if (json['options'] != null) {
      var optionsList = json['options'] as List<dynamic>;
      parsedOptions = optionsList.map((v) => Option.fromJson(v)).toList();
    }

    final bool parsedPicked = json['picked'];
    final int parsedPickedOption = json['pickedOption'];

    return Survey(
      id: parsedId,
      question: parsedQuestion,
      options: parsedOptions,
      picked: parsedPicked,
      pickedOption: parsedPickedOption
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = _id;
    data['question'] = _question;
    data['options'] = _options;
    data['picked'] = _picked;
    data['pickedOption'] = _pickedOption;
    return data;
  }

  @override
  String toString() {
    return 'Survey{_id: $_id, _question: $_question, _options: $_options, _picked: $_picked, _pickedOption: $_pickedOption}';
  }

  bool isPicked() {
    if (_picked == true) {
      return true;
    } else {
      return false;
    }
  }
}