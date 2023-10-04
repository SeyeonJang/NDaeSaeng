import 'package:dart_flutter/src/presentation/mypage/view/my_page_landing.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/mypages_cubit.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/state/mypages_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyPages extends StatefulWidget {
  const MyPages({Key? key}) : super(key: key);

  @override
  State<MyPages> createState() => _MyPagesState();
}

class _MyPagesState extends State<MyPages> with AutomaticKeepAliveClientMixin {
  @override
  // bool get wantKeepAlive => true;
  bool get wantKeepAlive {
    if (context.read<MyPagesCubit>().state.friends.length < 4) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Stack(
        children: [
          BlocBuilder<MyPagesCubit, MyPagesState>(
              builder: (context, state) {
                if (state.isMyLandPage) {
                  return const MyPageLanding();
                }
                return SafeArea(child: Center(child: Text(state.toString())));
              }
          ),
          BlocBuilder<MyPagesCubit, MyPagesState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return const SizedBox();
            },
          ),

          // BlocBuilder<MyPagesCubit, MyPagesState>(
          //   builder: (context, state) {
          //       return SafeArea(child: Text(state.toString()));
          //   },
          // ),
        ]
    );
  }
}
