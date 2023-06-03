import 'package:flutter/material.dart';

class ChooseId extends StatelessWidget {
  const ChooseId({Key? key}) : super(key: key);

  static final List<String> items = ['--', '23', '22', '21', '20', '19', '18', '17', '16', '15', '14', '13', '12', '11', '10'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back)),
          ),
        body: Center(
          child: Center(
            child: Container(
              child: ListWheelScrollView(
                  controller: FixedExtentScrollController(initialItem: 0), // 시작 위치
                  physics: const FixedExtentScrollPhysics(),
                  itemExtent: 60,
                  children: List.generate(items.length, (idx) {
                    return Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            items[idx],
                            style: const TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }),
                ),
            ),
          ),
        ),
    );
  }
}
