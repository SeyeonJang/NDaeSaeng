void main() {
  Abc page_state = Abc.page_a;
  page_state.printMe();  // 메인페이지

  // page_state = Abc.page_b;  // 다음 페이지 버튼을
  // page_state.printMe();

  if (page_state == Abc.page_a) {
    print("메인페이지에요");
  }
  if (page_state == Abc.page_b) {
    print("다음 페이지에요");
  }
}

enum Abc {
  page_a, page_b, page_c;

  void printMe() {
    print(this.toString());
  }
}
