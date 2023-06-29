import 'package:dart_flutter/src/presentation/signup/land_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/auth/auth_cubit.dart';

class LogoutTogoLandPage extends StatelessWidget {
  const LogoutTogoLandPage({Key? key}) : super(key: key);

  // ver. 3
  Future<void> goToLandPages(BuildContext context) async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LandPages()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
        create: (BuildContext context) => AuthCubit(),
        child: const LandPages(),
    );
  }
}
