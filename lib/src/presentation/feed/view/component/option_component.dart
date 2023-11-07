import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/domain/entity/option.dart';
import 'package:flutter/material.dart';

class OptionComponent extends StatefulWidget {
  late Option option;
  late double percent;
  late bool isMost;
  late bool isPicked;
  late bool isChanged;

  OptionComponent({super.key,
    required this.option,
    required this.percent,
    required this.isMost,
    required this.isPicked,
    required this.isChanged
  });

  @override
  State<OptionComponent> createState() => _OptionComponentState();
}

class _OptionComponentState extends State<OptionComponent> {
  Color mainColor = const Color(0xffFE6059);
  Color subColor = const Color(0xffFFE0B2);
  late double width;

  @override
  void initState() {
    super.initState();
    width = widget.isChanged ? 0 : SizeConfig.screenWidth * 0.77 * widget.percent ;
    WidgetsBinding.instance.addPostFrameCallback((_) => _changeProperties());
  }

  void _changeProperties() {
    setState(() {
      width = SizeConfig.screenWidth * 0.77 * widget.percent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.defaultSize * 4.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(9)),
        border: Border.all(color: widget.isMost ? mainColor : Colors.grey.shade300)
      ),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 2000),
            curve: Curves.easeOutQuint,
            width: width,
            height: SizeConfig.defaultSize * 4.5,
            decoration: BoxDecoration(
                color: widget.isMost ? mainColor.withOpacity(0.7) : subColor,
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
                      Icon(widget.isPicked ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded, size: SizeConfig.defaultSize * 1.8),
                      Text('   ${widget.option.name}'),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: SizeConfig.defaultSize * 1.2),
                    child: Text('${(widget.percent*100).toStringAsFixed(0)}%', style: TextStyle(
                      color: widget.isMost ? mainColor : Colors.grey
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
