class MyCache {
  DateTime _updateTime = DateTime.now().subtract(const Duration(days: 365));

  void setObject(dynamic object) {
    _updateTime = DateTime.now();
  }

  bool isUpdateBefore(DateTime dateTime) {
    return _updateTime.isBefore(dateTime);
  }

  void clean() {
    _updateTime = DateTime.now().subtract(const Duration(days: 365));
  }

  DateTime get updateTime => _updateTime;
}
