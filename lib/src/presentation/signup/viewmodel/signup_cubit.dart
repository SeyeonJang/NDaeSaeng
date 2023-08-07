
import 'package:dart_flutter/src/data/repository/dart_auth_repository.dart';
import 'package:dart_flutter/src/data/repository/dart_univ_repository.dart';
import 'package:dart_flutter/src/data/repository/dart_user_repository.dart';
import 'package:dart_flutter/src/domain/entity/university.dart';
import 'package:dart_flutter/src/presentation/signup/viewmodel/state/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entity/user_request.dart';

class SignupCubit extends Cubit<SignupState> {
  static final DartUniversityRepository _dartUniversityRepository = DartUniversityRepository();
  static final DartAuthRepository _authRepository = DartAuthRepository();
  static final DartUserRepository _dartUserRepository = DartUserRepository();

  SignupCubit() : super(SignupState.init());

  void initState([String memo = "", String loginType = ""]) async {
    state.isLoading = true;
    emit(state.copy());

    List<University> universities = await _dartUniversityRepository.getUniversites();
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
    // state.inputState.tempUnivDepartment = univDepartment;
    // state.inputState.univId = _findUniversityId(state.universities, state.inputState.tempUnivName!, state.inputState.tempUnivDepartment!);
    state.inputState.univId = university.id;
    print (state.inputState.univId);
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
      state.memo = state.memo ?? '';
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
    print("phone : $phone");

    // await _authRepository.requestSns(SnsRequest(phone: phone));

    // state.signupStep = SignupStep.validatePhone;
    state.signupStep = SignupStep.gender;
    emit(state.copy());
  }

  Future<String> stepValidatePhone(String validateCode) async {
    // bool result = await _authRepository.requestValidateSns(SnsVerifyingRequest(code: validateCode));
    // if (!result) {  // 전화번호 인증 실패
    //   state.signupStep = SignupStep.phone;
    //   emit(state.copy());
    //   return "번호 인증에 실패하였습니다.";  // TODO UI로 표현하기
    // }

    state.signupStep = SignupStep.gender;
    emit(state.copy());
    return '';
  }

  void stepGender(String gender) {
    state.inputState.gender = gender;
    print(state.inputState.toString());

    UserRequest userRequest = state.inputState.toUserRequest();
    print(userRequest.toString());
    _signupRequest(userRequest);

    emit(state.copy());
  }

  void _signupRequest(UserRequest userRequest) async {
    await _dartUserRepository.signup(userRequest);
  }

  // @override
  // void onChange(Change<SignupState> change) {
  //   super.onChange(change);
  // }
}
