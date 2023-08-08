import 'package:dart_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/auth/auth_cubit.dart';

class LogoutTogoLandPage extends StatelessWidget {
  const LogoutTogoLandPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
        create: (BuildContext context) => AuthCubit(),
        // child: const LandPages(),
        child: MyApp(),
    );
  }
}
