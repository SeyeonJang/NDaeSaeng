import 'package:dart_flutter/src/domain/entity/university.dart';

class UniversityFinder {
  final List<University> universities;

  UniversityFinder({
    required this.universities,
  });

  List<Map<String, dynamic>> getNameSuggestions(String query) {
    List<Map<String, dynamic>> matches = [];

    List<String> names = _getNameSuggestions(query).cast<String>();
    for (String name in names) {
      matches.add({
        'name': name,
      });
    }
    return matches;
  }

  List<Map<String, dynamic>> getDepartmentSuggestions(String univName, String query) {
    List<Map<String, dynamic>> matches = [];

    List<University> univs = _getDepartmentSuggestions(univName, query);
    for (var univ in univs) {
      matches.add(univ.toJson());
    }
    return matches;
  }

  List<String> _getNameSuggestions(String query) {
    List<String> universityNames = universities.map((university) => university.name).toList().toSet().toList();
    List<String> matches = [];
    for (var name in universityNames) {
      if (name.contains(query)) {
        matches.add(name);
      }
    }
    return matches;
  }

  List<University> _getDepartmentSuggestions(String univName, String query) {
    List<University> matches = [];

    for (var university in universities) {
      if (university.name == univName && university.department.contains(query)) {
        matches.add(university);
      }
    }

    return matches;
  }
}
