/// 과팅 팀을 조회한 횟수를 기록함
class MeetBoardCounter {
  static int count = 0;

  static void add() {
    count++;
  }

  static int get() {
    return count;
  }
}
