import 'package:dart_flutter/src/presentation/vote/vote_pages.dart';
import 'package:dart_flutter/src/presentation/vote/vote_result_view.dart';
import 'package:dart_flutter/src/presentation/vote/vote_timer.dart';
import 'package:dart_flutter/src/presentation/vote/vote_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const VotePages(),
      // home: const VoteView(),
      // home: const VoteResultView(),
      // home: const VoteTimer(),
    );
  }
}

class testbluewidget extends StatelessWidget {
  const testbluewidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: EdgeInsets.all(50),
        child: Text("hello", style: TextStyle(fontWeight: FontWeight.w800)),
      ),
    );
  }
}
