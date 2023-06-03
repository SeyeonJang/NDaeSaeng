import 'package:flutter/material.dart';

class CertNum extends StatefulWidget {
  final String userName;
  final String phoneNumber;

  CertNum({required this.userName, required this.phoneNumber});

  @override
  _CertNumState createState() => _CertNumState();
}

class _CertNumState extends State<CertNum> {
  TextEditingController _certNumController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Certification Number'),
        ),
        body: Padding(
        padding: const EdgeInsets.all(18.0),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text('Name: ${widget.userName}'),
    Text('Phone Number: ${widget.phoneNumber}'),
    const SizedBox(height: 16.0),
      ElevatedButton(
        onPressed: () {
          // 인증번호 확인 로직 구현
        },
        child: const Text('확인'),
      ),
    ],
    ),
        ),
    );
  }
}
