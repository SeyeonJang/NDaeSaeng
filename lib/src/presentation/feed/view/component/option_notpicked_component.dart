import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/domain/entity/option.dart';
import 'package:flutter/material.dart';

class OptionNotPickedComponent extends StatefulWidget {
  late Option option;
  final Function(bool, int) onPickedChanged;

  OptionNotPickedComponent({super.key, required this.option, required this.onPickedChanged});

  @override
  State<OptionNotPickedComponent> createState() => _OptionNotPickedComponentState();
}

class _OptionNotPickedComponentState extends State<OptionNotPickedComponent> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPickedChanged(true, widget.option.id);
      },
      child: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.defaultSize * 4.5,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(9)),
            border: Border.all(color: Colors.grey.shade300)
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: SizeConfig.defaultSize * 1.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.option.name),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
