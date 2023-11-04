import 'package:hydrated_bloc/hydrated_bloc.dart';

class PageViewCubit extends HydratedCubit<bool> {
  PageViewCubit() : super(true);

  void neverAgain() => emit(false);
  bool getState() => state;

  @override
  bool? fromJson(Map<String, dynamic> json) {
    return json['value'] as bool;
  }

  @override
  Map<String, dynamic>? toJson(bool state) {
    return {'value': state};
  }
}
