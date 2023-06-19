import 'package:dart_flutter/src/data/model/sns_request.dart';
import 'package:dart_flutter/src/data/model/university.dart';
import 'package:dart_flutter/src/data/model/user.dart';
import 'package:dart_flutter/src/data/repository/dart_auth_repository.dart';
import 'package:dart_flutter/src/data/repository/dart_univ_repository.dart';
import 'package:dart_flutter/src/data/repository/dart_user_repository.dart';
import 'package:dart_flutter/src/presentation/signup/viewmodel/state/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SignupCubit extends Cubit<SignupState> {
  static final DartUniversityRepository _dartUniversityRepository = DartUniversityRepository();
  static final DartAuthRepository _authRepository = DartAuthRepository();
  static final DartUserRepository _dartUserRepository = DartUserRepository();

  SignupCubit() : super(SignupState.init());

  void stepSchool(String univName) {
    state.inputState.tempUnivName = univName;
    state.signupStep = SignupStep.department;
    emit(state.copy());
  }

  void stepDepartment(String univDepartment) {
    state.inputState.tempUnivDepartment = univDepartment;
    state.inputState.univId = 1;  // TODO 서버로부터 받아온 대학목록에서 일치하는 학교-학과를 찾아 등록하는 로직
    state.signupStep = SignupStep.admissionNumber;
    emit(state.copy());
  }

  void stepAdmissionNumber(int admissionNumber) {
    state.inputState.admissionNumber = admissionNumber;
    state.signupStep = SignupStep.name;
    emit(state.copy());
  }

  void stepName(String name) {
    state.inputState.name = name;
    state.signupStep = SignupStep.phone;
    emit(state.copy());
  }

  void stepPhone(String phone) async {
    state.inputState.phone = phone;

    String deviceId = '';  //TODO device 고유 ID 얻어오기, DART API 나오면 아래 주석 풀기
    // await _authRepository.requestSns(SnsRequest(deviceId: '', phone: phone, snsCode: ''));

    state.signupStep = SignupStep.validatePhone;
    emit(state.copy());
  }

  Future<String> stepValidatePhone(String validateCode) async {
    // bool result = await _authRepository.requestValidateSns(SnsRequest(deviceId: '', phone: state.inputState.phone!, snsCode: validateCode));
    bool result = true;  //TODO DART API 나오면 위 주석 풀기
    if (!result) {  // 전화번호 인증 실패
      state.signupStep = SignupStep.phone;
      emit(state.copy());
      return "번호 인증에 실패하였습니다.";
    }

    state.signupStep = SignupStep.gender;
    emit(state.copy());
    return '';
  }

  void stepGender(String gender) async {
    state.inputState.gender = gender;

    UserRequest userRequest = state.inputState.toUserRequest();
    await _dartUserRepository.signup(userRequest);

    emit(state.copy());
  }

  @override
  void onChange(Change<SignupState> change) {
    super.onChange(change);
  }
}
