import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/domain/entity/option.dart';
import 'package:flutter/material.dart';

class OptionComponent extends StatelessWidget {
  late Option option;
  late double percent;
  late bool isMost;
  late bool isPicked;
  Color mainColor = const Color(0xffFE6059);
  Color subColor = const Color(0xffFFE0B2);

  OptionComponent({super.key,
    required this.option,
    required this.percent,
    required this.isMost,
    required this.isPicked
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.defaultSize * 4.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(9)),
        border: Border.all(color: isMost ? mainColor : Colors.grey.shade300)
      ),
      child: Stack(
        children: [
          Container(
            width: SizeConfig.screenWidth * 0.77 * percent,
            height: SizeConfig.defaultSize * 4.5,
            decoration: BoxDecoration(
                color: isMost ? mainColor.withOpacity(0.7) : subColor,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(9), bottomLeft: Radius.circular(9))
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: SizeConfig.defaultSize * 4.5,
            child: Padding(
              padding: EdgeInsets.only(left: SizeConfig.defaultSize),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(isPicked ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded, size: SizeConfig.defaultSize * 1.8),
                      Text('   ${option.name}'),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: SizeConfig.defaultSize * 1.2),
                    child: Text('${(percent*100).toStringAsFixed(0)}%', style: TextStyle(
                      color: isMost ? mainColor : Colors.grey
                    ),),
                  )
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }
}
