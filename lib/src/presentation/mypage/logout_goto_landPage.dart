import 'package:dart_flutter/src/presentation/signup/land_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/auth/auth_cubit.dart';

class LogoutTogoLandPage extends StatelessWidget {
  const LogoutTogoLandPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
        create: (BuildContext context) => AuthCubit(),
        child: const LandPages(),
    );
  }
}
