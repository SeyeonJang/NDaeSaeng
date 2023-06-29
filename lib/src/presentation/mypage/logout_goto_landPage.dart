import 'package:dart_flutter/src/presentation/signup/land_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/auth/auth_cubit.dart';

class LogoutTogoLandPage extends StatelessWidget {
  const LogoutTogoLandPage({Key? key}) : super(key: key);

  // ver. 3
  Future<void> goToLandPages(BuildContext context) async {
    await BlocProvider.of<AuthCubit>(context).kakaoLogout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LandPages()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // 로그아웃이 완료되면 이 위젯은 렌더링되지 않음
  }



    // ver.2 (실패!)
    // Future<void> goToLandPages() async {
    //   await BlocProvider.of<AuthCubit>(context).kakaoLogout();
    //   Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(builder: (context) => const LandPages()),
    //         (route) => false,
    //   );
    // }
    //
    // goToLandPages(); // 바로 LandPages() 이동
    //
    // return Container(); // 로그아웃이 잘 되면 이게 실행 안 되고 위에 goToLandPages() 실행됨

    // ver.1 (실패!)
    // return BlocProvider<AuthCubit>(
    //     create: (BuildContext context) => AuthCubit(),
    //     child: const LandPages(),
    // );
}
