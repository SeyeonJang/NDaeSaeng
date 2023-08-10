import 'package:dart_flutter/src/domain/entity/user_response.dart';
import 'package:flutter/material.dart';

class StudentVertificationIng extends StatelessWidget { // 인증중
  final UserResponse userResponse;

  const StudentVertificationIng({super.key, required this.userResponse});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Text("학생증 인증 중이에요!")
          ],
        ),
      ),
    );
  }
}
