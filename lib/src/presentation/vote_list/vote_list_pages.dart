import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/presentation/vote_list/viewmodel/state/vote_list_state.dart';
import 'package:dart_flutter/src/presentation/vote_list/viewmodel/vote_list_cubit.dart';
import 'package:dart_flutter/src/presentation/vote_list/vote_detail_view.dart';
import 'package:dart_flutter/src/presentation/vote_list/vote_list_inform_view.dart';
import 'package:dart_flutter/src/presentation/vote_list/vote_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VoteListPages extends StatefulWidget {
  const VoteListPages({Key? key}) : super(key: key);

  @override
  State<VoteListPages> createState() => _VoteListPagesState();
}

class _VoteListPagesState extends State<VoteListPages> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        // SafeArea(child: Center(child: Text("hello"))),
        BlocBuilder<VoteListCubit, VoteListState>(
          buildWhen: (previous, current) {
            return !current.isLoading;
          },
          builder: (context, state) {
            if (state.isFirstTime) {
              AnalyticsUtil.logEvent("투표목록_안내_접속");
              return const VoteListInformView();
            }
            if (!state.isFirstTime) {
              if (state.isDetailPage) {
                return const VoteDetailView();
              } else {
                AnalyticsUtil.logEvent("투표목록_받은투표_접속", properties: {
                  "받은 투표 개수": state.votes.length
                });
                return const VoteListView();
              }
            }
            return SafeArea(child: Center(child: Text(state.toString())));
          },
        ),

        // BlocBuilder<VoteListCubit, VoteListState> (
        //   builder: (context, state) {
        //     if (state.isLoading) {
        //       return Center(child: CircularProgressIndicator());
        //     }
        //     return SizedBox();
        //   }
        // ),

        // BlocBuilder<VoteListCubit, VoteListState>(
        //   builder: (context, state) {
        //     return SafeArea(child: Container(alignment: Alignment.bottomCenter,child: Text(state.toString(), style: TextStyle(color: Colors.red))));
        //   },
        // ),
      ],
    );
  }
}
