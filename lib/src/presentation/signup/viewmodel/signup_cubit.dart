import 'package:dart_flutter/src/domain/entity/university.dart';
import 'package:dart_flutter/src/domain/use_case/university_use_case.dart';
import 'package:dart_flutter/src/domain/use_case/user_use_case.dart';
import 'package:dart_flutter/src/presentation/signup/viewmodel/state/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/user_request.dart';

class SignupCubit extends Cubit<SignupState> {
  static final UniversityUseCase _universityUseCase = UniversityUseCase();
  static final UserUseCase _userUseCase = UserUseCase();

  SignupCubit() : super(SignupState.init());

  void initState([String memo = "", String loginType = ""]) async {
    state.isLoading = true;
    emit(state.copy());

    List<University> universities = await _universityUseCase.getUniversities();
    state.universities = universities;

    state.memo = memo;
    state.loginType = loginType;
    state.isLoading = false;
    emit(state.copy());
  }

  List<University> get getUniversities => state.universities;

  void stepSchool(String univName) {
    state.inputState.tempUnivName = univName;
    state.signupStep = SignupStep.department;
    emit(state.copy());
  }

  void stepDepartment(University university) {
    state.inputState.univId = university.id;
    state.signupStep = SignupStep.admissionNumber;
    emit(state.copy());
  }

  int _findUniversityId(List<University> universities, String name, String department) {
    for (University university in universities) {
      if (university.name == name && university.department == department) {
        return university.id;
      }
    }
    return -1; // 해당 조건을 만족하는 대학을 찾지 못한 경우 -1 반환
  }

  void stepAdmissionNumber(int admissionNumber, int bornYear) {
    state.inputState.admissionNumber = admissionNumber;
    state.inputState.birthYear = bornYear;

    state.inputState.phone = '01000000000';  //TODO 전화번호 인증 적용후 제거

    bool isIos = state.loginType.contains("apple");
    if (isIos) {
      state.memo = state.memo;
      state.inputState.name = state.memo.isEmpty ? '오늘' : state.memo;
      state.signupStep = SignupStep.gender;
    } else {
      state.signupStep = SignupStep.name;
    }

    emit(state.copy());
  }

  void stepName(String name) {
    state.inputState.name = name;
    state.signupStep = SignupStep.gender;
    emit(state.copy());
  }

  void stepPhone(String phone) async {
    state.inputState.phone = phone;
    state.signupStep = SignupStep.gender;
    emit(state.copy());
  }

  Future<String> stepValidatePhone(String validateCode) async {
    state.signupStep = SignupStep.gender;
    emit(state.copy());
    return '';
  }

  void stepGender(String gender) async {
    state.isLoading = true;
    emit(state.copy());

    try {
      state.inputState.gender = gender;
      UserRequest userRequest = state.inputState.toUserRequest();
      print(userRequest.toString());
      await _signupRequest(userRequest);
    } catch(e, trace) {
      print(e);
      print(trace);
      throw Error();
    } finally {
      state.isLoading = false;
      emit(state.copy());
    }
  }

  Future<void> _signupRequest(UserRequest userRequest) async {
    await _userUseCase.signup(userRequest);
  }
}
